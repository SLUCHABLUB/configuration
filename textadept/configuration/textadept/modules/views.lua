-- Helpers for settings that belong to views rather than buffers.

local views = {}

-- Applies a function to every view,
-- both those that exist once textadept has initialised and those opened later.
function views.for_each(apply)
    events.connect(events.INITIALIZED, function()
        for _, existing_view in ipairs(_VIEWS) do apply(existing_view) end
    end)
    events.connect(events.VIEW_NEW, function() apply(view) end)
end

return views
