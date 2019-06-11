local launch_args = ...
display.setStatusBar(display.HiddenStatusBar)

local json = require('json')
local widget = require('widget')
local facebook = require('plugin.spiralcode.facebook')

display.setDefault('background', 1)

if launch_args then
	print('launch_args')
	print(json.prettify(launch_args))
end

Runtime:addEventListener('notification', function(event)
	print('notification event')
	print(json.prettify(event))
end)

Runtime:addEventListener('system', function(event)
	print('system event')
	print(json.prettify(event))
end)

local xl, xr, y = display.contentWidth * .25, display.contentWidth * .75, display.contentCenterY
local w, h = display.contentWidth * 0.4, 50

widget.newButton{
	x = xl, y = y - 200,
	width = w, height = h,
	label = 'Init',
	onRelease = function()
		print('init')
		facebook.init{
			autoLogAppEvents = true,
			advertiserIdCollection = true
		}
	end}

widget.newButton{
	x = xr, y = y - 200,
	width = w, height = h,
	label = 'Deferred AppLink',
	onRelease = function()
		print('getDeferredAppLinkData')
		facebook.getDeferredAppLinkData{
			listener = function(event)
				print(json.prettify(event))
				if not event.isError then
					native.showAlert('Deferred AppLink', event.url, {'OK'})
				end
			end
		}
	end}

widget.newButton{
	x = xl, y = y - 120,
	width = w, height = h,
	label = 'Log event1',
	onRelease = function()
		print('log event1')
		facebook.logEvent{name = 'event1'}
	end}

widget.newButton{
	x = xr, y = y - 120,
	width = w, height = h,
	label = 'Log event2',
	onRelease = function()
		print('log event2')
		facebook.logEvent{name = 'event2', value = 10, params = {fb_description = 'custom description'}}
	end}

widget.newButton{
	x = xl, y = y - 40,
	width = w, height = h,
	label = 'Log purchase',
	onRelease = function()
		print('log purchase')
		facebook.logPurchase{value = 3.45, currency = 'USD'}
	end}

widget.newButton{
	x = xr, y = y - 40,
	width = w, height = h,
	label = 'Set limit',
	onRelease = function()
		print('setLimitEventAndDataUsage')
		facebook.setLimitEventAndDataUsage(true)
	end}
