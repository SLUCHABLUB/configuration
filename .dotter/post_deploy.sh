#!/bin/sh

{{#if dotter.packages.bat}}
bat cache --build
{{/if}}
