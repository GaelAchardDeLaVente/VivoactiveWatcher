// get data from garmin API and update the step number of the day in firestore
exports.getNewDailyStepsData = async function(db) {
    const newAPIData = getExampleAPIResponse();
    const newData = {
        "date": new Date(newAPIData.calendarDate),
        "stepsNumber": newAPIData.steps,
    }
    console.log(newData);
    const snapshot = await db.collection("weekSteps").get();
    snapshot.forEach(async stepData => {
        if (new Date((stepData.data().date._seconds + 7200) * 1000).setHours(0,0,0,0) == newData.date.setHours(0,0,0,0)) {
            await db.collection("weekSteps").doc(stepData.id).update({"stepsNumber": newData.stepsNumber});
        }
    });
}

function getAPIDailySummary() {
    // TODO
}

function getExampleAPIResponse() {

    // Date format example
    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1; //Months are zero based
    var curr_year = d.getFullYear();
    var calenderDate = curr_year + "-" + (curr_month<10 ? "0" + curr_month : curr_month)  + "-" + curr_date;

    // Steps number example
    var steps = d.getHours()*300 + Math.floor(Math.random()*300);

    const response = {
        "summaryId": " EXAMPLE_67891",
        "calendarDate": calenderDate, // format "2016-01-13"
        "activityType": "WALKING",
        "activeKilocalories": 321,
        "bmrKilocalories": 1731,
        "consumedCalories": 1121,
        "steps": steps,
        "distanceInMeters": 3146.5,
        "durationInSeconds": 86400,
        "activeTimeInSeconds": 12240,
        "startTimeInSeconds": 1452470400,
        "startTimeOffsetInSeconds": 3600,
        "moderateIntensityDurationInSeconds": 81870,
        "vigorousIntensityDurationInSeconds": 4530,
        "floorsClimbed": 8,
        "minHeartRateInBeatsPerMinute": 59,
        "averageHeartRateInBeatsPerMinute": 64,
        "maxHeartRateInBeatsPerMinute": 112,
        "averageStressLevel": 43,
        "maxStressLevel": 87,
        "stressDurationInSeconds": 13620,
        "restStressDurationInSeconds": 7600,
        "activityStressDurationInSeconds": 3450,
        "lowStressDurationInSeconds": 6700,
        "mediumStressDurationInSeconds": 4350,
        "highStressDurationInSeconds": 108000,
        "stressQualifier": "stressful_awake",
        "stepsGoal": 4500,
        "netKilocaloriesGoal": 2010,
        "intensityDurationGoalInSeconds": 1500,
        "floorsClimbedGoal": 18
    };
    return response;
}

