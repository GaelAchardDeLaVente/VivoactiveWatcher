const functions = require("firebase-functions");
const firebaseAdmin = require("firebase-admin");
// const region = "us-central1";

firebaseAdmin.initializeApp();

const db = firebaseAdmin.firestore();

const resetWeekSteps = require('./src/reset_week_steps');
const getNewDailyStepsData = require('./src/get_new_daily_steps_data');

// Debug http function
// exports.debugResetWeekSteps = functions.https.onRequest(async (req, res) => {
//   await resetWeekSteps.resetWeekSteps(db);
//   res.send({"success":"maybe"});
// });

// Debug http function
// exports.debugGetNewStepsData = functions.https.onRequest(async (req, res) =>{
//   await getNewDailyStepsData.getNewDailyStepsData(db);
//   res.send({"success":"maybe"});
// });

exports.scResetWeekSteps = functions.pubsub.schedule("every monday 00:00")
    .onRun(async (context) => {
      await resetWeekSteps.resetWeekSteps(db);
    });

exports.scGetNewStepsData = functions.pubsub.schedule("every 5 minutes")
    .onRun(async (context) => {
      await getNewDailyStepsData.getNewDailyStepsData(db);
    });
