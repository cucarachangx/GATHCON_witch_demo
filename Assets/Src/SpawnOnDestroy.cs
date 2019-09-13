using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SpawnOnDestroy : MonoBehaviour {

    public bool rotationIdentity = false;
    public bool usePlaceHolder = false;
    [Serializable]
    public class PrefabCount {
        public GameObject prefab = null;
        public GameObject parentPlaceholder = null;
        public int count = 0;
    }


    public PrefabCount[] objectsToSpawn;

    private void OnDestroy() {
        if(objectsToSpawn == null || objectsToSpawn.Length == 0)
            return;

        foreach(var obj in objectsToSpawn) {
            if(obj == null || obj.count == 0 || obj.prefab == null)
                continue;

            for(int i = 0; i < obj.count; i++) {
                GameObject newGO = Instantiate<GameObject>(
                    obj.prefab,
                    (usePlaceHolder) ? obj.parentPlaceholder.transform.position : transform.position,
                    (rotationIdentity) ? Quaternion.identity : transform.rotation);
            }
        }
    }
}
