#!/bin/sh
# shellcheck disable=all

missing=false

{{#each commands as |names package|}}
{{#each names as |command|}}
{{#unless (is_executable command)}}
echo "{{package}} needs {{command}}, which is not installed" >&2
missing=true
{{/unless}}
{{/each}}
{{/each}}

if [ "$missing" = true ]
then
    exit 1
fi
