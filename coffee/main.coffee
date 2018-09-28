electron  = require 'electron'
path      = require 'path'
url       = require 'url'

{ app, BrowserWindow, Menu, dialog, nativeImage } = electron

# main window
# Keep a global reference of the window object, if you don't, the window will
# be closed automatically when the JavaScript object is garbage collected.
win = null
icon = nativeImage.createFromPath path.join __dirname, './img/air-e.png'
debugging = on

createWindow = () ->
  win = new BrowserWindow
            width: 1000, height: 600
            title: 'Air quaity'
            background: '#002b36'
            icon: './img/air-e.png'

  win.loadFile './views/home.html'
  
  win.maximize()
  win.webContents.openDevTools() if process.argv[2] is '--dev'
  console.log process.argv

  # build menu
  mnutmpl = [
    {
      label: 'File'
      submenu: [
        {
            label: 'Debugging'
            accelerator: 'Ctrl+Shift+I'
            type: 'checkbox'
            checked: debugging
            role: 'toggledevtools'
            click: () ->
              debugging = not debugging
              win.webContents.toggleDevTools()
        },
        { type: 'separator' },
        {
          label: 'Quit', accelerator: 'Ctrl+Q', click: () -> app.quit()
        }
      ]
    },
    {
      label: 'View'
      submenu: [
        {
          label: 'Latest measurements', click: () -> win.loadFile './views/home.html'
        },
        { type: 'separator' },
        {
          label: 'Measurements for period', click: () -> win.loadFile './views/query.html'
        }
      ]
    },
    {
      label: 'About'
      click: () ->
        dialog.showMessageBox win,
          type: 'info'
          title: 'About'
          message: 'About message...'
          detail: 'Details here...'
          buttons: ['ok']
#          icon: icon
#          icon: electron.nativeImage.createFromPath path.join __dirname, '../img/air-e.png'
#          icon: path.join __dirname, '../img/air-e.png'
        , (btn, chk) -> console.log btn, chk
    }
  ]
  menu = Menu.buildFromTemplate mnutmpl
  Menu.setApplicationMenu menu


  # emitted when the window is closed
  # Dereference the window object, usually you would store windows
  # in an array if your app supports multi windows, this is the time
  # when you should delete the corresponding element.
  win.on 'closed', () ->
    # close any other windows here
    win = null  

  # return val from createWindow()
  null

# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
# Some APIs can only be used after this event occurs.
app.on 'ready', () ->
  createWindow()

  # process command arguments via process.argv

  # create other windows here

# On macOS it's common to re-create a window in the app when the
# dock icon is clicked and there are no other windows open.
app.on 'activate', () ->
  createWindow() if win is null

# Quit when all windows are closed.
# On macOS it is common for applications and their menu bar
# to stay active until the user quits explicitly with Cmd + Q
app.on 'window-all-closed', () ->
  app.quit() unless process.platform is 'darwin'

# TODO:
# load lang object from url:
#
# http://air.moepp.gov.mk/graphs/site/js/lang.mk.js
