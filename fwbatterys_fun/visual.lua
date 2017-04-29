addEventHandler("onClientResourceStart", resourceRoot,

function()

GUIEditor = {
    button = {}
}
        GUIEditor.MirrorPanel = guiCreateStaticImage(143, 249, 981, 471, ":fwbatterys/visual/background.png", false)
        guiSetProperty(GUIEditor.MirrorPanel, "ImageColours", "tl:9B24FF00 tr:9B24FF00 bl:9B24FF00 br:9B24FF00")

        GUIEditor.Panel = guiCreateStaticImage(10, 10, 961, 451, ":fwbatterys/visual/background.png", false, GUIEditor.MirrorPanel)
        guiSetProperty(GUIEditor.Panel, "ImageColours", "tl:7D24FF00 tr:7D24FF00 bl:7D24FF00 br:7D24FF00")

        GUIEditor.Title = guiCreateLabel(238, 10, 487, 76, "\"FIREWORKS\"", false, GUIEditor.Panel)
        guiSetFont(GUIEditor.Title, "sa-gothic")
        guiLabelSetColor(GUIEditor.Title, 75, 179, 0)
        GUIEditor.Settings = guiCreateStaticImage(10, 10, 279, 38, ":fwbatterys/visual/menu_settings.png", false, GUIEditor.Panel)
        GUIEditor.About = guiCreateStaticImage(762, 10, 216, 39, ":fwbatterys/visual/menu_about.png", false, GUIEditor.Panel)

        GUIEditor.fwbatterys1 = guiCreateButton(10, 96, 218, 59, "Firework:\nfwbatterys 1", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys1, 0.75)
        guiSetFont(GUIEditor.fwbatterys1, "clear-normal")


        GUIEditor.fwbatterys2 = guiCreateButton(10, 165, 218, 59, "Firework:\nfwbatterys 2", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys2, 0.75)
        guiSetFont(GUIEditor.fwbatterys2, "clear-normal")


        GUIEditor.fwbatterys3 = guiCreateButton(10, 234, 218, 59, "Firework:\nfwbatterys 3", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys3, 0.75)
        guiSetFont(GUIEditor.fwbatterys3, "clear-normal")


        GUIEditor.fwbatterys4 = guiCreateButton(10, 303, 218, 59, "Firework:\nfwbatterys 4", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys4, 0.75)
        guiSetFont(GUIEditor.fwbatterys4, "clear-normal")


        GUIEditor.fwbatterys5 = guiCreateButton(10, 372, 218, 59, "Firework:\nfwbatterys 5", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys5, 0.75)
        guiSetFont(GUIEditor.fwbatterys5, "clear-normal")


        GUIEditor.fwbatterys6 = guiCreateButton(733, 96, 218, 59, "Firework:\nfwbatterys 6", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys6, 0.75)
        guiSetFont(GUIEditor.fwbatterys6, "clear-normal")


        GUIEditor.fwbatterys7 = guiCreateButton(733, 165, 218, 59, "Firework:\nfwbatterys 7", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys7, 0.75)
        guiSetFont(GUIEditor.fwbatterys7, "clear-normal")


        GUIEditor.fwbatterys8 = guiCreateButton(733, 234, 218, 59, "Firework:\nfwbatterys 8", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys8, 0.75)
        guiSetFont(GUIEditor.fwbatterys8, "clear-normal")


        GUIEditor.fwbatterys9 = guiCreateButton(733, 303, 218, 59, "Firework:\nfwbatterys 9", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys9, 0.75)
        guiSetFont(GUIEditor.fwbatterys9, "clear-normal")


        GUIEditor.fwbatterys10 = guiCreateButton(733, 372, 218, 59, "Firework:\nfwbatterys 10", false, GUIEditor.Panel)
        guiSetAlpha(GUIEditor.fwbatterys10, 0.75)
        guiSetFont(GUIEditor.fwbatterys10, "clear-normal")
        guiSetVisible ( GUIEditor.MirrorPanel, false )







    end)

bindKey ( "F6", "down", function ( )
        local state = ( not guiGetVisible ( GUIEditor.MirrorPanel ) )
        guiSetVisible ( GUIEditor.MirrorPanel, state )
        showCursor ( state )
    end
)