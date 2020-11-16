import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const env = functions.config();

import algoliasearch from 'algoliasearch';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


//initialize algolia search :
// const client = 
const client = algoliasearch(env.algolia.appid, env.algolia.apikey);
//calling the stories index in angolia
const storyIndex = client.initIndex('Stories');

        // storyIndexId,
        // ...storyData

//adding objects to the index when an object is added
exports.indexStories = functions.firestore
.document('PublicStories/{StoriesID}')
.onCreate((snap, context) => {
    const storyData = snap.data();
    const storyIndexId = snap.id ;

    storyIndex.saveObject({
        objectID : storyIndexId,
        StoryData: storyData
    });

    return ""
});


//Deleting objects in the index when an object is deleted
exports.unIndexStories = functions.firestore
.document('PublicStories/{StoriesID}')
.onDelete((snap, context) => {
    const storyIndexId = snap.id;

    storyIndex.deleteObject(storyIndexId);

    return storyIndex.deleteObject(storyIndexId);
});