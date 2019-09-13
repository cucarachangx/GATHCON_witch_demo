using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SpawnOnDestroy : MonoBehaviour {

    [Serializable]
    public class PrefabCount {
        public GameObject prefab = null;
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
                    transform.position,
                    transform.rotation);
            }
        }
    }
}
