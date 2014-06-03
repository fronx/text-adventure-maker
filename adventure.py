import json
import time

with open('story.json') as f:
    story = json.load(f)

def wait():
    for _ in range(3):
        time.sleep(0.5)
        print '.'

step = story['start']
print step['text']

while 'options' in step:
    for index, option in enumerate(step['options']):
        print index + 1, option['text']
    n = int(input()) - 1
    choice = step['options'][n]
    if 'transition' in choice:
        print choice['transition']
    wait()
    step = story[choice['target']]
    print step['text']
