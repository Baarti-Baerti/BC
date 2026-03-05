#!/bin/sh
# Fix Railway volume permissions (mounted as root, need appuser access)
mkdir -p /data/garth_squad
chown -R appuser:appuser /data
chmod 700 /data/garth_squad

# Drop to appuser and start gunicorn
exec gosu appuser gunicorn \
    --bind 0.0.0.0:${PORT:-8080} \
    --workers 2 \
    --timeout 120 \
    --preload \
    --access-logfile - \
    --error-logfile - \
    "api.server:app"
