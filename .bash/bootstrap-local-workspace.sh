#!/bin/bash
cp ./.git-hooks/post-checkout ./.git/hooks/post-checkout
chmod +x ./.git/hooks/post-checkout
echo "post-checkout hook is installed successfully."