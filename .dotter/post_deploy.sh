#!/bin/sh

set -euo pipefail

{{#if dotter.packages.bat}}
bat cache --build
{{/if}}
