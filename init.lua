hyperKey = '`'
hyperKey2 = '\\'
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

mouseCircle = nil
mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-200, mousepoint.y-200, 400, 400))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)

hs.hotkey.bind({"cmd","alt"}, "up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd","alt"}, "down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y + max.h / 2
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd","alt"}, "left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd","alt"}, "right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"ctrl","alt"}, "up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.y = f.y - 100
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"ctrl","alt"}, "down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.y = f.y + 100
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"ctrl","alt"}, "left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = f.x - 100
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"ctrl","alt"}, "right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = f.x + 100
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"ctrl","cmd"}, "up", function() local win = hs.window.focusedWindow() local f = win:frame() f.h = f.h - 100 win:setFrame(f, 0) end)
hs.hotkey.bind({"ctrl","cmd"}, "down", function() local win = hs.window.focusedWindow() local f = win:frame() f.h = f.h + 100 win:setFrame(f, 0) end)
hs.hotkey.bind({"ctrl","cmd"}, "left", function() local win = hs.window.focusedWindow() local f = win:frame() f.w = f.w - 100 win:setFrame(f, 0) end)
hs.hotkey.bind({"ctrl","cmd"}, "right", function() local win = hs.window.focusedWindow() local f = win:frame() f.w = f.w + 100 win:setFrame(f, 0) end)

-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, 'F17')

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

function exitHyperMode()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, hyperKey)
  else
    hs.task.new("/Users/sunny/iptmthd", function(code,out,err) hs.alert.show(string.gsub(out, '%s+', ''), {textSize=96}, hs.screen.mainScreen(), 0.5) end):start()
  end
  hyper:exit()
end

function exitHyperMode2()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, hyperKey2)
  else
    hs.task.new("/Users/sunny/iptmthd", function(code,out,err) hs.alert.show(string.gsub(out, '%s+', ''), {textSize=96}, hs.screen.mainScreen(), 0.5) end):start()
  end
  hyper:exit()
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)
f19 = hs.hotkey.bind({}, 'F19', enterHyperMode, exitHyperMode2)

-- set up your windowfilter
switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
switcher.ui.highlightColor = {0.4,0.4,0.5,0.8}
switcher.ui.thumbnailSize = 112
switcher.ui.showTitles = false
switcher.ui.showThumbnails = false
switcher.ui.showSelectedThumbnail = false
switcher.ui.showSelectedTitle = false
switcher.ui.selectedThumbnailSize = 284
switcher.ui.backgroundColor = {0.3, 0.3, 0.3, 0.5}
switcher.ui.fontName = 'System'
switcher.ui.textSize = 14

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.window.animationDuration = 0
-- hs.hotkey.bind("cmd","F18",function()switcher:next()end)
hs.hotkey.bind("cmd","F18",function()hs.eventtap.keyStroke({"cmd"},hyperKey)end)
hs.hotkey.bind("shift","F18",function()hs.eventtap.keyStroke("shift",hyperKey)end)
hs.hotkey.bind("ctrl","F18",function()hs.eventtap.keyStroke("ctrl",hyperKey)end)
hs.hotkey.bind("alt","F18",function()hs.eventtap.keyStroke("alt",hyperKey)end)
-- hs.hotkey.bind("cmd-shift","F18",function()switcher:previous()end)
hs.hotkey.bind("cmd-shift","F18",function()hs.eventtap.keyStroke("cmd-shift",hyperKey)end)
hs.hotkey.bind("ctrl-shift","F18",function()hs.eventtap.keyStroke("ctrl-shift",hyperKey)end)
hs.hotkey.bind("alt-shift","F18",function()hs.eventtap.keyStroke("alt-shift",hyperKey)end)

hs.hotkey.bind("cmd","F19",function()hs.eventtap.keyStroke({"cmd"},hyperKey2)end)
hs.hotkey.bind("shift","F19",function()hs.eventtap.keyStroke("shift",hyperKey2)end)
hs.hotkey.bind("ctrl","F19",function()hs.eventtap.keyStroke("ctrl",hyperKey2)end)
hs.hotkey.bind("alt","F19",function()hs.eventtap.keyStroke("alt",hyperKey2)end)
hs.hotkey.bind("cmd-shift","F19",function()hs.eventtap.keyStroke("cmd-shift",hyperKey2)end)
hs.hotkey.bind("ctrl-shift","F19",function()hs.eventtap.keyStroke("ctrl-shift",hyperKey2)end)
hs.hotkey.bind("alt-shift","F19",function()hs.eventtap.keyStroke("alt-shift",hyperKey2)end)

hyper:bind({},'a',function() hyper.triggered = true hs.application.launchOrFocus('Android Studio') end)
hyper:bind({},'b',function() hyper.triggered = true hs.alert.show('Bundle?') end)
hyper:bind({},'c',function() hyper.triggered = true hs.application.launchOrFocus('Google Chrome') end)
hyper:bind({},'d',function() hyper.triggered = true hs.execute('open ~/Downloads') end)
-- hyper:bind({},'e',function() hyper.triggered = true hs.application.launchOrFocus('Finder') end)
hyper:bind({},'e',function() hyper.triggered = true hs.application.get('Finder'):activate() end)
hyper:bind({},'f',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('org.mozilla.firefox') end)
hyper:bind({},'g',function() hyper.triggered = true hs.application.launchOrFocus('GoodNotesMac') end)
hyper:bind({},'h',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon') end)
hyper:bind({},'i',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('com.jetbrains.intellij.ce') end)
hyper:bind({},'j',function() hyper.triggered = true hs.application.launchOrFocus('Simulator') end)
hyper:bind({},'k',function() hyper.triggered = true hs.application.get('qemu-system-x86_64'):activate() end)
hyper:bind({},'l',function() hyper.triggered = true hs.application.launchOrFocus('iTerm') end)
hyper:bind({},'m',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('com.torusknot.SourceTreeNotMAS') end)
hyper:bind({},'n',function() hyper.triggered = true hs.application.launchOrFocus('Notion') end)
hyper:bind({},'o',function() hyper.triggered = true
    hs.applescript('do shell script "ls -t -d ~/Downloads/* | head -n1 | xargs echo -n | xargs -0 open"')
end)
hyper:bind({},'p',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('com.apple.systempreferences') end)
hyper:bind({},'q',function() hyper.triggered = true hs.application.launchOrFocus('Quip') end)
hyper:bind({},'r',function() hyper.triggered = true hs.alert.show('Run?') end)
hyper:bind({},'s',function() hyper.triggered = true hs.application.launchOrFocus('Slack') end)
hyper:bind({},'t',function() hyper.triggered = true hs.application.launchOrFocusByBundleID('com.apple.SafariTechnologyPreview') end)
hyper:bind({},'u',function() hyper.triggered = true hs.application.launchOrFocus('YouTube') end)
hyper:bind({},'v',function() hyper.triggered = true hs.application.launchOrFocus('MacVim') end)
hyper:bind({},'w',function() hyper.triggered = true hs.application.launchOrFocus('WhatsApp') end)
hyper:bind({},'x',function() hyper.triggered = true hs.application.launchOrFocus('Xcode') end)
hyper:bind({},'y',function() hyper.triggered = true hs.eventtap.keyStroke("cmd-ctrl","v") end)
hyper:bind({},'z',function() hyper.triggered = true hs.caffeinate.systemSleep() end)

-- Input Method Changing
-- OS X BUG: https://www.bountysource.com/issues/6480182-is-it-possible-to-change-the-input-source-automatically-by-application
-- workaround: switch to previous source and trigger keystroke to switch to "next"
-- still won't work, needa "unregister" last CJKV layout
hyper:bind({},'1',function() hyper.triggered = true
  hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
  hs.keycodes.setLayout('ABC')
end)

hyper:bind({},'2',function() hyper.triggered = true
  -- hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
  -- hs.eventtap.keyStroke({"ctrl", "alt"}, "space")
  hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
  hs.keycodes.setLayout('ABC')
  hs.keycodes.currentSourceID('com.apple.inputmethod.TYIM.Cangjie')
  -- hs.keycodes.setLayout('Cangjie')
end)

hyper:bind({},'3',function() hyper.triggered = true
  -- hs.keycodes.currentSourceID('com.apple.inputmethod.TCIM.Cangjie')
  -- hs.eventtap.keyStroke({"ctrl", "alt"}, "space")
  hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
  hs.keycodes.setLayout('ABC')
  hs.keycodes.currentSourceID('com.apple.inputmethod.TCIM.Pinyin')
  -- hs.keycodes.setLayout('Traditional Pinyin')
end)

hyper:bind({},'4',function() hyper.triggered = true
  hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
  hs.keycodes.setLayout('ABC')
  hs.keycodes.currentSourceID('com.apple.keylayout.Colemak')
end)

hyper:bind({},'up',function()
  hyper.triggered = true
  hs.osascript.applescript([[
tell application "System Events"
    tell process "NotificationCenter"
        repeat 3 times
            repeat with iWindow in (get windows)
                try
                    click button "Close" of iWindow
                end try
            end repeat
        end repeat
    end tell
end tell
  ]])
end)

hyper:bind({},'down',function()
  hyper.triggered = true
  hs.osascript.applescript([[
tell application "System Events"
    tell process "NotificationCenter"
        set numwins to (count windows)
        repeat with i from 1 to numwins by 1
            try
                click button "Close" of window i
            end try
        end repeat
    end tell
end tell
  ]])
end)

hyper:bind({},'left',function()
  hyper.triggered = true
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local current = win:screen()
  local orig = current:frame()
  local screen = current:toWest()
  local target = screen:frame()
  f.x = f.x - orig.x + target.x
  f.y = f.y - orig.y + target.y
  if ( f.x + f.w > target.w )
  then f.x = target.w - f.w
  end
  if ( f.y + f.h > target.h )
  then f.y = target.h - f.h
  end
  win:setFrame(f, 0)
end)

hyper:bind({},'right',function()
  hyper.triggered = true
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local current = win:screen()
  local orig = current:frame()
  local screen = current:toEast()
  local target = screen:frame()
  f.x = f.x - orig.x + target.x
  f.y = f.y - orig.y + target.y
  if ( f.x + f.w > target.w )
  then f.x = target.w - f.w
  end
  if ( f.y + f.h > target.h )
  then f.y = target.h - f.h
  end
  win:setFrame(f, 0)
end)


hyper:bind({},'tab',function() hyper.triggered = true
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local center = hs.geometry.rectMidPoint(f)
  hs.mouse.setAbsolutePosition(center)
  mouseHighlight()
end)


hs.hotkey.bind({"ctrl"}, "3", function()
  hs.alert.show("triggered")
  hs.applescript('do shell script "mv -f /Users/sunny/workspace/KotlinDemo/drawdemo/build/classes/kotlin/js/main/drawdemo.js /Users/sunny/workspace/KotlinDemo/webJs/"')
end)

-- hs.hotkey.bind({"ctrl"}, "4", function()
--   hs.alert.show("triggered")
--   hs.applescript('do shell script "mv -f /Users/sunny/workspace/KotlinDemo/drawdemo/build/bin/wasm32/debugExecutable/drawdemo.wasm /Users/sunny/workspace/KotlinDemo/webWasm/"')
-- end)

hs.hotkey.bind({"ctrl"}, "4", function()
  hs.alert.show("triggered")
  hs.applescript('do shell script "cp /Users/sunny/workspace/KotlinDemo/schema/cinterop/*.dylib /Users/sunny/workspace/KotlinDemo/schema/build/classes/kotlin/main/"')
end)

-- hyper:bind({},'w',function() hyper.triggered = true
--   hs.osascript.javascript([[
--     // below is javascript code
--     var chrome = Application('Google Chrome');
--     chrome.activate();
--     var wins = chrome.windows;

--     // loop tabs to find a web page with a title of <name>
--     function main() {
--         for (var i = 0; i < wins.length; i++) {
--             var win = wins.at(i);
--             win.visible = false;
--             var tabs = win.tabs;
--             for (var j = 0; j < tabs.length; j++) {
--             var tab = tabs.at(j);
--             tab.title(); j;
--             if (tab.title().indexOf(']] .. 'WhatsApp' .. [[') > -1 || tab.title().indexOf(']] .. 'YouTube' .. [[') > -1) {
--                     win.activeTabIndex = j + 1;
--                     win.visible = true;
--                     return;
--                 }
--             }
--         }
--     }
--     main();
--     // end of javascript
--   ]])
-- end)

-- mirrorKey = 'space'

-- -- A global variable for the Mirror Mode
-- mirror = hs.hotkey.modal.new({}, 'F15')

-- -- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
-- function enterMirrorMode()
--   mirror.triggered = false
--   mirror:enter()
-- end

-- function exitMirrorMode()
--   mirror:exit()
--   if not mirror.triggered then
--     hs.eventtap.keyStroke({}, mirrorKey)
--   end
-- end

-- f16 = hs.hotkey.bind({}, 'F16', enterMirrorMode, exitMirrorMode)

-- mirror:bind({}, 'space', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'space') end)
-- mirror:bind({}, 'y', function() mirror.triggered = true hs.eventtap.keyStroke({}, 't') end)
-- mirror:bind({}, 'u', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'r') end)
-- mirror:bind({}, 'i', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'e') end)
-- mirror:bind({}, 'o', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'w') end)
-- mirror:bind({}, 'p', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'q') end)
-- mirror:bind({}, 'h', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'g') end)

-- mirror:bind({}, 'j', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'f') end)
-- mirror:bind({}, 'k', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'd') end)
-- mirror:bind({}, 'l', function() mirror.triggered = true hs.eventtap.keyStroke({}, 's') end)
-- mirror:bind({}, ';', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'a') end)

-- mirror:bind({}, 'n', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'v') end)
-- mirror:bind({}, 'm', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'c') end)
-- mirror:bind({}, ',', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'x') end)
-- mirror:bind({}, '.', function() mirror.triggered = true hs.eventtap.keyStroke({}, 'z') end)

-- hs.hotkey.bind("cmd","F16",function()hs.eventtap.keyStroke({"cmd"},mirrorKey)end)
-- hs.hotkey.bind("shift","F16",function()hs.eventtap.keyStroke("shift",mirrorKey)end)
-- hs.hotkey.bind("ctrl","F16",function()hs.eventtap.keyStroke("ctrl",mirrorKey)end)
-- hs.hotkey.bind("alt","F16",function()hs.eventtap.keyStroke("alt",mirrorKey)end)
-- hs.hotkey.bind("cmd-shift","F16",function()hs.eventtap.keyStroke("cmd-shift",mirrorKey)end)
-- hs.hotkey.bind("ctrl-shift","F16",function()hs.eventtap.keyStroke("ctrl-shift",mirrorKey)end)
-- hs.hotkey.bind("alt-shift","F16",function()hs.eventtap.keyStroke("alt-shift",mirrorKey)end)
-- hs.hotkey.bind("cmd-alt","F16",function()hs.eventtap.keyStroke("cmd-shift",mirrorKey)end)
-- hs.hotkey.bind("ctrl-alt","F16",function()hs.eventtap.keyStroke("ctrl-shift",mirrorKey)end)
-- hs.hotkey.bind("cmd-alt-shift","F16",function()hs.eventtap.keyStroke("cmd-shift",mirrorKey)end)
-- hs.hotkey.bind("ctrl-alt-shift","F16",function()hs.eventtap.keyStroke("ctrl-shift",mirrorKey)end)

-- Show message when reloaded
hs.alert.show('hammerspoon configuration reloaded')
