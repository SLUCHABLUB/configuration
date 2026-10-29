#!/bin/sh

# shellcheck disable=all

{{#if dotter.packages.bat}}
bat cache --build
{{/if}}
