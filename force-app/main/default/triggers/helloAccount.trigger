trigger helloAccount on Account (before insert) {
system.debug('Hello Account');

}