#!/usr/bin/env python

# Simple script to get project info.

import subprocess
import yaml
import sys
from ConfigParser import ConfigParser
from StringIO import StringIO



class Informer(object):


  def __init__(self):
    source_file = "docker-compose.override.yml"
    self.parse_env()
    self.parse_docker_info()



  def parse_env(self):
    self.parser = ConfigParser()
    with open(".env") as stream:
      stream = StringIO("[general]\n" + stream.read())
      self.parser.readfp(stream)
    #print(self.parser.items("general"))



  def get_env_value(self, key):
    return self.parser.get("general", key)



  def parse_docker_info(self):
    docker_info_stream = subprocess.check_output(['docker-compose', 'config'])
    self.info = yaml.safe_load(docker_info_stream)



  def get_docker_conf(self, route):
    current = self.info
    for index in route:
      if index in current:
        current = current[index]
      else:
        return None

    return current



  def get_urls(self):
    raw_ports = self.get_docker_conf(['services', 'traefik', 'ports'])
    self.urls = []

    for port_info in raw_ports:
      if port_info['target'] == 80:
        protocol = 'http'
      elif port_info['target'] == 443:
        protocol = 'https'
      else:
        protocol = 'http(s)'

      base_url = self.get_env_value('project_base_url')
      self.urls += ["{}://{}:{}".format(protocol, base_url, port_info['published'] )]


    if len(self.urls) == 0:
      print("It seems the traefik port is not configured in the '{}' file".format(source_file))



  def show(self):

    self.get_urls()

    output = "\nProject urls:"

    for url in self.urls:
      output += "\n  {}".format(url)

    print(output)





informer = Informer()
informer.show()







