#!/bin/bash

# 1. Grab the currently focused client JSON
CLIENT_JSON=$(mmsg get focusing-client)

# Safety check: if no window is focused (empty or null), exit
if [ -z "$CLIENT_JSON" ] || [ "$CLIENT_JSON" == "null" ]; then
    exit 0
fi

# 2. Extract client details
CLIENT_ID=$(echo "$CLIENT_JSON" | jq -r '.id')
TAG_COUNT=$(echo "$CLIENT_JSON" | jq '.tags | length')
CLIENT_MONITOR=$(echo "$CLIENT_JSON" | jq -r '.monitor')

# 3. Smart close logic
if [ "$TAG_COUNT" -eq 1 ]; then
    # The focused window only exists on one tag. Kill it completely.
    mmsg dispatch killclient client,"$CLIENT_ID"
else
    # The window exists on multiple tags. Untag it from the active tag.

    # Reliably fetch the active tag for the specific monitor the client is on.
    # We pipe to `head -n 1` just in case you are viewing multiple tags at once.
    ACTIVE_TAG=$(mmsg get all-tags | jq -r --arg mon "$CLIENT_MONITOR" '.all_tags[] | select(.monitor == $mon) | .tags[] | select(.is_active == true) | .index' | head -n 1)

    # STRICT SAFETY CHECK: Ensure ACTIVE_TAG is a positive integer (1 or higher).
    # This entirely prevents the "toggle all tags" bug.
    if [[ "$ACTIVE_TAG" =~ ^[1-9][0-9]*$ ]]; then
        mmsg dispatch toggletag,"$ACTIVE_TAG" client,"$CLIENT_ID"
    else
        echo "Error: Invalid ACTIVE_TAG detected ('$ACTIVE_TAG'). Aborting to prevent toggling all tags."
        exit 1
    fi
fi
