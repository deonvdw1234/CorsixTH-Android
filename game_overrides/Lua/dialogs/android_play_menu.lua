-- Nieto Software override of CorsixTH/Lua/dialogs/android_play_menu.lua from the
-- jni/CorsixTH submodule (alanwoolley/CorsixTH, Android branch). Packed into
-- game.zip in place of the original by build.gradle (createGameZip).
-- Created by Nieto Software

class "UIAndroidPlayMenu"(Window)

local TH = require("TH")

function UIAndroidPlayMenu:UIAndroidPlayMenu(ui)
    self:Window()

    local app = ui.app
    self.app = app
    self.ui = ui
    self.on_top = true
    self.resizable = true
    self.draggable = false
    self.esc_closes = false
    self.visible = true
    self.x = 10
    self.y = 10
    self.width = 48
    self.height = 48
    self.signed_in = true

    self.panel_sprites = self.app.gfx:loadSpriteTable("Bitmap", "android", true, self.app.gfx:loadPalette("Bitmap", "android.pal"))
    self:resetPanels()
end

function UIAndroidPlayMenu:signInPressed()
    TH.android.signIn()
end

function UIAndroidPlayMenu:openAchievementsPressed()
    TH.android.showAchievements()
end

function UIAndroidPlayMenu:resetPanels()
    self:removeAllPanels()

    -- Nieto Software: Google Play Games is not part of this build, so the
    -- sign-in and achievements icons are not shown. The window stays (app.lua
    -- creates it) but has nothing to draw or tap.
    if true then return end

    local signin_normal = 22
    local signin_pressed = 26
    local achievements_normal = 20
    local achievements_pressed = 24

    if (self.signed_in) then
        signin_normal = 23
        signin_pressed = 27
        achievements_normal = 21
        achievements_pressed = 25
    end

    self:addPanel(signin_normal, 0, 0, self.width, self.height):setTooltip("Sign in with Google Play Games"):makeButton(0, 0, self.width, self.height, signin_pressed, self.signInPressed)
    self:addPanel(achievements_normal, 0, 68, self.width, self.height):setTooltip("Open Achievements"):makeButton(0, 0, self.width, self.height, achievements_pressed, self.openAchievementsPressed)
end
