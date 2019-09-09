using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarWeapon : MonoBehaviour {
    public float cooldown = 0.5f;
    public float range = 10f;

    [Space]
    [SerializeField] AvatarBullet bulletPrefab = null;

    float cooldownTimer = 0f;
    bool shooting = false;

    // Start is called before the first frame update
    void Start() {

    }

    // Update is called once per frame
    void Update() {
        cooldownTimer -= Time.deltaTime;
        if(shooting && cooldownTimer <= 0) {
            Shoot();
            cooldownTimer = cooldown;
        }
    }

    public void SetShooting(bool shooting) {
        this.shooting = shooting;
    }

    public void Shoot() {
        var cosestTarget = FindClosestTarget();

        if(cosestTarget != null && Vector3.Distance(cosestTarget.transform.position, transform.position) <= range) {
            AvatarBullet newBullet = Instantiate<AvatarBullet>(bulletPrefab);
            newBullet.transform.position = transform.position;
            newBullet.transform.LookAt(cosestTarget.transform, Vector3.up);
            Debug.DrawLine(transform.position, cosestTarget.transform.position, Color.red, 0.1f);
        }
    }

    AvatarWeaponTarget FindClosestTarget() {
        AvatarWeaponTarget closestTarget = null;
        float closestTargetSqrDist = -1f;
        foreach(var t in AvatarWeaponTarget.availableTargets) {
            if(closestTarget == null || Vector3.SqrMagnitude(transform.position - t.transform.position) < closestTargetSqrDist) {
                closestTargetSqrDist = Vector3.SqrMagnitude(transform.position - t.transform.position);
                closestTarget = t;
            }
        }
        return closestTarget;
    }

    private void OnDrawGizmosSelected() {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, range);
    }

}
