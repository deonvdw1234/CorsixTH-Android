-- Nieto Software override of CorsixTH/Lua/dialogs/android_menu_button.lua from the
-- jni/CorsixTH submodule (alanwoolley/CorsixTH, Android branch). Packed into
-- game.zip in place of the original by build.gradle (createGameZip).
-- Created by Nieto Software

class "UIAndroidMenuButton"(Window)

function UIAndroidMenuButton:UIAndroidMenuButton(ui)
    self:Window()

    local app = ui.app
    self.app = app
    self.ui = ui
    self.world = app.world
    self.on_top = true
    self.resizable = true
    self.draggable = false
    self.esc_closes = false
    self.visible = true
    self.x = app.config.width - 100
    self.y = 10
    self.width = 27
    self.height = 28
    self.menu_open = false

    self.android_menu = UIAndroidMenu(self.ui)

    self.panel_sprites = self.app.gfx:loadSpriteTable("Bitmap", "android", true, self.app.gfx:loadPalette("Bitmap", "android.pal"))

    -- Nieto Software: the touch area is larger than the 27x28 icon (25 pixels
    -- extra to the left, 10 to the right and 20 below, reaching the top edge)
    -- so the gear is easy to tap on a phone. The icon itself is unchanged.
    self:addPanel(12, 65, 0, self.width, self.height):setLabel("Menu"):makeButton(-25, -10, self.width + 35, self.height + 30, 13, self.buttonPressed):setTooltip("Open Menu")

end

function UIAndroidMenuButton:buttonPressed()
    if (not self.menu_open) then
        print("Opening menu")
        self:addWindow(self.android_menu)
        self.menu_open = true
    else
        print("Closing menu")
        self:removeWindow(self.android_menu)
        self.menu_open = false
    end
end

function UIAndroidMenuButton:onChangeResolution(width, height)
    self.x = self.ui.app.config.width - 100
end