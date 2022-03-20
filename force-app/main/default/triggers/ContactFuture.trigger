trigger ContactFuture on Account (after insert) {
    String Accjson = JSON.serialize(trigger.new);
    ContactFuture.ContactCreate(Accjson);
}