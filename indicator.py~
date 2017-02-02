#!/usr/bin/python2.7
import gtk
import gtk.glade
import appindicator
import sys, os
import signal
import errno
import json
import traceback
import requests
import subprocess

class App(object):
  def __init__(self):
    try:
        self.indicator = Indicator()
    except Exception as e:
        print e
        self.exit(1)

  def __del__(self):
    self.exit()

  def run(self):
      gtk.main()

  def exit(self, code=0):
    print "Killing!!!"
    gtk.main_quit()
    sys.exit(code)

class Indicator(object):
  def __init__(self):
      self.indicator = appindicator.Indicator(
        "indicatorApp",
        "app",
        appindicator.CATEGORY_APPLICATION_STATUS)
      self.setup_indicator()

  def setup_indicator(self):
      self.indicator.set_status(appindicator.STATUS_ACTIVE)
      self.indicator.set_icon(os.path.abspath('slack.svg'))
      self.indicator.set_menu(self.create_menu())

  def create_menu(self):
    menu = gtk.Menu()

    self.add_menu_item("Monitor", self._toggle_monitor, menu)
    self.add_menu_item("Offline", self._go_offline, menu)

    self.add_menu_separator(menu)
    self.add_menu_item("Quit", self._quit, menu)
    return menu

  def add_menu_item(self, label, handler, menu,
        event="activate", MenuItem=gtk.MenuItem, show=True):
    item = MenuItem(label)
    if label == "Monitor":
      item = gtk.CheckMenuItem("Monitor")
      item.set_active(True)
      self._toggle_monitor(item)
    item.connect(event, handler)
    menu.append(item)
    if show:
        item.show()
    return item

  def add_menu_separator(self, menu, show=True):
      item = gtk.SeparatorMenuItem()
      menu.append(item)
      if show:
          item.show()

  def _toggle_monitor(self, item):
    if (item.get_active() == True):
      try:
        subprocess.Popen(["pkill -f /bin/sh\ ./monitorBus.sh"], shell=True)
        subprocess.Popen(['nohup ./monitorBus.sh  > /dev/null 2>&1 &'], shell=True)
      except subprocess.CalledProcessError:
        print "Error !!"
        _quit()
    else:
      subprocess.Popen(["pkill -f /bin/sh\ ./monitorBus.sh"], shell=True)

  def _go_offline(self, item):
    self.update_status()

  def _quit(self, code=0):
    sys.exit(code)

  def update_status(self):
    status = 'away'
    url = ## URL
    return self._get(url, status)

  def _get(self, url, status):
    headers = {
        'Content-Type': 'application/json'
    }
    url+=  'presence=' + status
    err = None
    response = requests.get(
      url,
      headers=headers)
    print 'Status Update completed with ' + str(response.status_code)
    #self.indicator.set_icon(os.path.abspath('sample_icon.svg'))

def main():
  try:
    app = App()
    app.run()
  except KeyboardInterrupt:
    pass

if __name__ == '__main__':
  main()
