using UnityEngine;
using System;

// NO TOCAR!!!

public class Spawner : MonoBehaviour {

    [Serializable]
    public class SpawnedObjet {
        public GameObject prefab = null;
        public int count = 0;
        public float chances = 1f;
    }

    public enum TimeToSpawn {
        awake,
        onEnable,
        start,
        onDisable,
        onDestroy,
    }

    public TimeToSpawn timeToSpawn = TimeToSpawn.onDestroy;
    public bool wordRotation = false;
	public SpawnedObjet[] objectsToSpawn;

    private void Awake() {
        if(timeToSpawn == TimeToSpawn.awake)
            DoSpawn();
    }

    private void OnEnable() {
        if(timeToSpawn == TimeToSpawn.onEnable)
            DoSpawn();
    }

    private void Start() {
        if(timeToSpawn == TimeToSpawn.start)
            DoSpawn();
    }

    private void OnDisable() {
        if(timeToSpawn == TimeToSpawn.onDisable)
            DoSpawn();
    }

    private void OnDestroy() {
        if(timeToSpawn == TimeToSpawn.onDestroy)
            DoSpawn();
    }

    public void DoSpawn() {
        if(objectsToSpawn == null || objectsToSpawn.Length == 0)
            return;

        foreach(var obj in objectsToSpawn) {
            if(obj == null || obj.count == 0 || obj.prefab == null)
                continue;

            for(int i = 0; i < obj.count; i++) {
                GameObject newGO = Instantiate<GameObject>(
                    obj.prefab,
                    transform.position,
                    (wordRotation) ? Quaternion.identity : transform.rotation);
            }
        }
    }

    [Space]
    [SerializeField] bool drawGizmos = false;
    [SerializeField] Color gizmoColor = Color.white;
    private void OnDrawGizmos() {
        if(drawGizmos) {
            Gizmos.color = gizmoColor;
            Gizmos.DrawCube(transform.position, transform.localScale);
        }
    }
}