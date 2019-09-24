using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class GoblinMovement : EnemyMovement
{
    public float visionRadius = 15;
    public Vector3[] autoPathPoints = null;
    private Enemy enemyScript;
    private NavMeshAgent nav;

    [Space]
    [SerializeField] float autopathReachDist = 1f;
    int autoPathIdx = 0;
    bool following = false;
    Animator animator = null;


    protected override void Start() {
        base.Start();
        animator = GetComponent<Animator>();
        enemyScript = GetComponent<Enemy>();
        nav = GetComponent<NavMeshAgent>();
    }

    private void Update() {
        animator.SetFloat("Speed", 0f);
        if(following) {
            UpdateFollowing();

            if(Avatar.currentAvatar == null ||
                Vector3.Distance(transform.position, Avatar.currentAvatar.transform.position) > visionRadius) {
                following = false;
            }
        }
        else {
            UpdateAutopath();

            if(Avatar.currentAvatar != null &&
                Vector3.Distance(transform.position, Avatar.currentAvatar.transform.position) <= visionRadius) {
                following = true;
            }
        }
        if (enemyScript.life <= 0)
            nav.enabled = false;
    }

    void UpdateFollowing() {
        if(Avatar.currentAvatar != null) {
            base.agent.destination = Avatar.currentAvatar.transform.position;
            animator.SetFloat("Speed", speed);
        }
        else
            following = false;
    }

    void UpdateAutopath() {
        Vector3 dest = startPositoon;
        if(autoPathPoints != null && autoPathPoints.Length > 0) {
            float dist = Vector3.Distance(transform.position, autoPathPoints[autoPathIdx]);
            if(dist <= autopathReachDist) {
                autoPathIdx++;
                if(autoPathIdx >= autoPathPoints.Length)
                    autoPathIdx = 0;
            }
            dest = autoPathPoints[autoPathIdx];
        }
        if (nav.isActiveAndEnabled)
        {
            base.agent.destination = dest;
        }
        animator.SetFloat("Speed", speed);
    }

    private void OnDrawGizmosSelected() {
        Gizmos.color = Color.green;
        Gizmos.DrawWireSphere(transform.position, visionRadius);

        if(autoPathPoints != null && autoPathPoints.Length > 0) {
            Vector3 last = autoPathPoints[0];
            for(int i = 1; i < autoPathPoints.Length; i++)
                Gizmos.DrawLine(last, autoPathPoints[i]);
            Gizmos.DrawLine(autoPathPoints[0], autoPathPoints[autoPathPoints.Length - 1]);

            foreach(var app in autoPathPoints)
                Gizmos.DrawSphere(app, 0.3f);
        }

        Gizmos.color = Color.cyan;
        Vector3 dest = startPositoon;
        if(autoPathPoints != null && autoPathPoints.Length > 0)
            dest = autoPathPoints[autoPathIdx];
        Gizmos.DrawSphere(dest, 0.3f);
        Gizmos.DrawLine(transform.position, dest);
    }

}
