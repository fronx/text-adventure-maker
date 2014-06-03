import json
import time

with open('story.json') as f:
    story = json.load(f)

here = story['start']
print here['text']

while 'options' in here:
    for index, option in enumerate(here['options']):
        print index + 1, option['text']
    n = int(input()) - 1
    choice = here['options'][n]
    if 'transition' in choice:
        print choice['transition']
    for _ in range(3):
        time.sleep(0.5)
        print '.'
    here = story[choice['target']]
    print here['text']
