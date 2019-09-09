using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoblinMovement : EnemyMovement
{
    public float visionRadius = 15;
    public Vector3[] autoPathPoints = null;

    [Space]
    [SerializeField] float autopathReachDist = 1f;
    int autoPathIdx = 0;
    bool following = false;

    private void Update() {
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
    }

    void UpdateFollowing() {
        if(Avatar.currentAvatar != null) {
            base.agent.destination = Avatar.currentAvatar.transform.position;
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
        
        base.agent.destination = dest;
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
