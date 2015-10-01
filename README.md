# Code Exercise

by: Scott Shervington

The purpose of this exercise is to gain some insight into your approach to analysis and implementation. Don't overthink it, don't spend too much time on it, and do have fun.

### Requirements
Create a Rails web service that has the following behaviors:
* Given a long URL, it will provide a short URL
* Given a short URL that it generated, it will provide the corresponding long URL


A URL shortener by itself is simply an apprentice project. 
Let's make it somewhat more interesting by adding some requirements:

* Short URLs are likely to be transcribed by hand, so they should accommodate common transcription ambiguities. O and 0 should be treated identically, for example.

* On the other hand, transcription errors should ideally not result in false results. The short URLspace should be sparse, specifically having the property that no two short URLs should differ by only one character.


### Bonus Round
The hallmark of a good design is how well it adapts to changing requirements. If you have the time and inclination, you might expand on the requirements with other sensible ideas, e.g.:

* Short URLs must not contain any string in a list of inappropriate words. The list should be stubbed as "foo" and "bar" while legal trawls 4chan and compiles a master list of terms calculated to give offense.


### Implementation
I decided to go with a very simple, straightforward approach.  I implemented some validation on the URL being passed in, then I save that along with a random 7-digit token in the DB.  Then I just do a lookup on the token and redirect to the URL.  

To deal with the issue of transcription ambiguities, I just removed (o,O,0...lI1) from the list of allowed characters, so that there are no issues with that.

To deal with inappropriate words, I test the newly created token against the blacklist of words and replace the offending matches with a new random set of characters drawn from a "clean" list of characters.


