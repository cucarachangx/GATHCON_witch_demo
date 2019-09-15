using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarWeapon : MonoBehaviour {
    public float cooldown = 0.5f;
    public float range = 10f;

    [Space]
    [SerializeField] AvatarBullet bulletPrefab = null;
    [SerializeField] Transform bulletOrigin = null;

    [SerializeField]
    Avatar avatarScr;

    float cooldownTimer = 0f;
    bool shooting = false;
    Animator animator = null;
    AvatarWeaponTarget cosestTarget = null;

    // Start is called before the first frame update
    void Start() {
        animator = GetComponent<Animator>();
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
        cosestTarget = FindClosestTarget();
        if (cosestTarget != null && Vector3.Distance(cosestTarget.transform.position, transform.position) <= range) {
            avatarScr.SFXManager(0);
            animator.SetTrigger("Attack");
            transform.LookAt(cosestTarget.transform.position, Vector3.up);
        }
    }

    //llamado desde animacion
    public void SpawnBullet() {
        if(cosestTarget == null)
            return;
        

        AvatarBullet newBullet = Instantiate<AvatarBullet>(bulletPrefab);
        newBullet.transform.position = (bulletOrigin != null) ? bulletOrigin.position : transform.position;

        Vector3 targetPos = new Vector3(
            cosestTarget.transform.position.x,
            newBullet.transform.position.y,
            cosestTarget.transform.position.z);
        newBullet.transform.LookAt(targetPos, Vector3.up);

        Debug.DrawLine(transform.position, cosestTarget.transform.position, Color.red, 0.1f);

        cosestTarget = null;
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
