# The simplest text adventure maker I could come up with

## Full source code with comments

```python
# The following two lines import code that other people
# have written so we don't have to write it ourselves.
import json
import time
# Pieces of code that can be imported are commonly called
# "libraries" or "modules".
# The way you usually find out what library to import
# is by googling the thing you want to do and the name
# of the programming language you're using, e.g.:
#
#   read json python
#
# When you've found a useful function, you just need to
# find out what library it's in. It takes some practice.

# Here we're using the json library to read the content
# of the file 'story.json' which contains our text
# adventure.
with open('story.json') as f:
    story = json.load(f)

# `here` is a variable in which we store the current position
# in the adventure story. We always starts at the entry
# with the key 'start'.
here = story['start']

# Show the start text.
print here['text']

# We want to run through the story as long as there
# are more things left for the player to do. If there
# are no more options, or next steps, the story is finished.
while 'options' in here:
    # For every single thing the player can do here,
    # print a number and the text.
    for index, option in enumerate(here['options']):
        print index + 1, option['text']
    # Wait for the player to choose what to do by
    # entering a number.
    n = int(input()) - 1
    # Go to the option the player picked.
    choice = here['options'][n]
    if 'transition' in choice:
        print choice['transition']
    # Wait a little, to make it more... exciting.
    for _ in range(3):
        time.sleep(0.5)
        print '.'
    # Go to the next point in the story.
    here = story[choice['target']]
    # Show what's there
    print here['text']
    # After this, the program continues at the
    # beginning of this while block.
```
