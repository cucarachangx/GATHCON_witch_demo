using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class EnemyMovement : MonoBehaviour
{
    public float speed = 10f;
    
    protected NavMeshAgent agent = null;
    protected Vector3 startPositoon = Vector3.zero;

    // Start is called before the first frame update
    protected virtual void Awake() {
        agent = GetComponent<NavMeshAgent>();
        agent.speed = speed;
    }

    protected virtual void Start() {
        startPositoon = transform.position;
    }
}
