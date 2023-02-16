# Tests


## Recording behat tests

Recording tests is a feature available for behat tests that are run into selenium. This means,
only works for @javascript tests.

To record in a mp4 file the behat test it is needed to follow these steps:

1. Start recording

`make record`

By doing this the chrome container will be grabbed, even the tests are not executed yet.
It is recommended to only start recording just before running the tests.

2. Run the tests

`behat --tags javascript`


3. Stop recording

`make record-stop`

It is recommended to do this just after the tests finishes.


4. Video edit

It is possible recommended to cut the video beginning and end so that the empty selenium screen does not appear and only appear
the text execution.