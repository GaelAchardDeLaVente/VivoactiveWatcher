// delete data of last week (save it in steps collection) and add new data with 0 step for everyday of the week
exports.resetWeekSteps = async function(db) {
    await deletePreviousWeekSteps(db).then(() => {
      initWeekSteps(db);
    });
}

async function initWeekSteps(db) {
    
    const mondayOfTheCurrentWeek = getMondayOfNow();

    for(let i = 0 ; i < 7 ; i++) {
        const notif = {
            date: new Date(new Date(mondayOfTheCurrentWeek + (86400000 * i)).setHours(-2, 0, 0, 0)),
            stepsNumber: 0,
        };

        await db.collection("weekSteps").add(notif);
    }
}

async function deletePreviousWeekSteps(db) {
    const query = db.collection("weekSteps");

    await db.collection("weekSteps").get().then((weekStepsCollection) => {
        weekStepsCollection.forEach(async (doc) => {
            await db.collection('steps').add(doc.data());
        });
    });

    return new Promise((resolve, reject) => {
        deleteQueryBatch(db, query, resolve).catch(reject);
    });
}

async function deleteQueryBatch(db, query, resolve) {
    const snapshot = await query.get();
  
    const batchSize = snapshot.size;
    if (batchSize === 0) {
      // When there are no documents left, we are done
      resolve();
      return;
    }
  
    // Delete documents in a batch
    const batch = db.batch();
    snapshot.docs.forEach(async (doc) => {
      batch.delete(doc.ref);
    });
    await batch.commit();
  
    // Recurse on the next process tick, to avoid
    // exploding the stack.
    process.nextTick(() => {
      deleteQueryBatch(db, query, resolve);
    });
}

function getMondayOfNow() {
    var d = new Date(Date.now());
    var day = d.getDay(),
        diff = d.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
    return d.setDate(diff);
  }