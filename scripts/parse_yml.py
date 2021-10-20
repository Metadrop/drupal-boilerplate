#!/usr/bin/env python

# Simple script to get project info.

import sys
import subprocess
import yaml
import re
import configparser
import io



class Informer(object):


  def __init__(self):
    source_file = "docker-compose.override.yml"
    self.parse_env()
    self.parse_docker_info()



  def parse_env(self):
    self.parser = configparser.ConfigParser()
    with open(".env") as stream:
      stream = io.StringIO("[general]\n" + stream.read())
      self.parser.read_file(stream)
    #print(self.parser.items("general"))



  def get_env_value(self, key):
    return self.parser.get("general", key)



  def parse_docker_info(self):
    docker_info_stream = subprocess.check_output(['docker-compose', 'config'])
    # print(docker_info_stream )
    self.info = yaml.safe_load(docker_info_stream)



  def get_docker_conf(self, route):
    current = self.info
    for index in route:
      if index in current:
        current = current[index]
      else:
        return None

    return current



  def get_ports(self):
    raw_ports = self.get_docker_conf(['services', 'traefik', 'ports'])
    self.ports = []

    for port_info in raw_ports:
      if port_info['target'] == 80:
        protocol = 'http'
      elif port_info['target'] == 443:
        protocol = 'https'
      else:
        protocol = 'http(s)'


      port_info = {
        'protocol': protocol,
        'port': port_info['published']
        }

      self.ports += [port_info]


    if len(self.ports) == 0:
      print("It seems the traefik port is not configured in the '{}' file".format(source_file))




  def get_urls(self):
    self.get_ports()

    self.urls = {}

     # Webserver url.
    self.urls['web'] = self.get_url('apache')

    if self.urls['web'] is None:
      self.urls['web'] = self.get_url('nginx')

    # Adminer.
    self.urls['adminer'] = self.get_url('adminer')

    # Docs.
    self.urls['mkdocs'] = self.get_url('mkdocs')



  def get_url(self, service):
    url = None
    value_dict = self.get_docker_conf(['services', service, 'labels'])


    if value_dict is not None:
      for key in value_dict.keys():
        if key.find('routers') != -1:
          break

      value = value_dict[key]
      results = re.search(r"`(.*)`", value)
      url = results.group(1)

    return url



  def format_service_urls(self, url):
    urls = [];
    for port in self.ports:
      urls += [ "{}://{}:{}".format(port["protocol"], url, port["port"])]

    return urls



  def format_service_section(self, service_name, url):
    urls = self.format_service_urls(url)

    indent_length = 25 - len(service_name)

    output = "  - {}".format(service_name)
    for url in urls:
      #output += " "*indent_length + url + "\n"
      output += "\n      " + url + "\n"

    output += "\n"
    return output



  def show(self):

    self.get_urls()

    output = "\nProject urls:\n\n"

    output += self.format_service_section('Site URL', self.urls['web'])
    output += self.format_service_section('Documentation', self.urls['mkdocs'])
    output += self.format_service_section('Database web interface', self.urls['adminer'])

    print(output)



informer = Informer()
informer.show()







