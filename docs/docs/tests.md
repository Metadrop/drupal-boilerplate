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

When this commands finishes, the video recorded will be located at tmp/chrome-video.mp4. Please note that the tmp folder is relative to the project codebase and not the /tmp folder.

4. Video edit

It is recommended to cut the video beginning and end so that the empty selenium screen does not appear and only the test execution appears.
