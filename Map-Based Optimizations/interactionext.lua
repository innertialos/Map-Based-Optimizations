function BaseInteractionExt:check_occlusion_state()
	if not self._materials or not next(self._materials)
	or not self._tweak_data or self._tweak_data.no_contour
	or not self._active
	or not self._contour_colour or self._contour_colour == Vector3(0, 0, 0)
	or not self._contour_opacity or self._contour_opacity == 0 then -- can't show contours/not active/contour is not being shown
		managers.occlusion:add_occlusion(self._unit)
	else
		managers.occlusion:remove_occlusion(self._unit)
	end
end

Hooks:PostHook(BaseInteractionExt, "refresh_material", "MBO_refresh_material", BaseInteractionExt.check_occlusion_state)
Hooks:PostHook(BaseInteractionExt, "set_tweak_data", "MBO_set_tweak_data", BaseInteractionExt.check_occlusion_state)
Hooks:PostHook(BaseInteractionExt, "set_active", "MBO_set_active", BaseInteractionExt.check_occlusion_state)
Hooks:PostHook(BaseInteractionExt, "set_contour", "MBO_set_contour", function(self, colour, opacity)
	self._contour_colour = tweak_data.contour[self._tweak_data.contour or "interactable"][colour]
	self._contour_opacity = opacity or self._active and 1 or 0

	self:check_occlusion_state()
end)