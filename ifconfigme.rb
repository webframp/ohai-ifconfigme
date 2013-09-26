#
# Author:: Sean Escriva <sean.escriva@gmail.com>
# Copyright:: Copyright (c) 2013 Sean Escriva
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provides 'ifconfigme'

require 'json'
require 'rest-client'

url = 'http://ifconfig.me/all.json'

begin
  response = RestClient.get(url)
  results = JSON.parse(response)

  if not results.nil?
    ifconfigme Mash.new
    if not results['ip_addr'].nil?
      ifconfigme[:ip] = results['ip_addr']
    end
    if not results['remote_host'].nil?
      ifconfigme[:hostname] = results['remote_host']
    end
  end

rescue RestClient::Exception
  Ohai::Log.debug("ifconfig.me lookup failed.")
end
