import argparse
import random
from pandevice import panorama, objects
import csv

# Parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument("hostname", help="Hostname of the Panorama device")
parser.add_argument("userid", help="User ID for the Panorama device")
parser.add_argument("password", help="Password for the Panorama device")
args = parser.parse_args()

# Create a Panorama object
pano = panorama.Panorama(args.hostname, args.userid, args.password)

# Create 10 dummy AddressObjects
addresses = []
for i in range(10):
    address = objects.AddressObject(f"dummy{i}", f"10.10.{i}.0/24")
    if not pano.find(address):
        pano.add(address)
        address.create()
        addresses.append(address)

# Create 5 AddressGroups with random addresses
for i in range(5):
    # Select 2 random addresses for the group
    group_addresses = random.sample(addresses, 2)
    group = objects.AddressGroup(f"group{i}", static_value=[addr.name for addr in group_addresses])
    if not pano.find(group):
        pano.add(group)
        group.create()

# Commit the changes to Panorama
pano.commit()

# Read the text file
with open('addresses.txt', 'r') as file:
    input_addresses = [line.strip() for line in file]

# Get all address groups
# Retrieve all address groups
all_address_groups = objects.AddressGroup.refreshall(pano)

# Now you can iterate over all_address_groups instead of using pano.findall
for address in input_addresses:
    groups = []
    for group in all_address_groups:
        if group.static_value and address in group.static_value:
            groups.append(group.name)
    if groups:
        print(f"{address}: {'; '.join(groups)}")
    else:
        print(f"{address}: No groups")
