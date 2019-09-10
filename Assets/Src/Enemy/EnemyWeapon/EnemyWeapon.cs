using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyWeapon : MonoBehaviour {
    public float cooldown = 0.5f;
    public float range = 3f;

    [Space]
    [SerializeField] EnemyBullet bulletPrefab = null;
    [SerializeField] Transform bulletOrigin = null;

    float cooldownTimer = 0f;
    Animator animator = null;

    // Start is called before the first frame update
    void Start() {
        animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update() {
        cooldownTimer -= Time.deltaTime;
        if(cooldownTimer <= 0) {
            Shoot();
            cooldownTimer = cooldown;
        }
    }

    public void Shoot() {
        if(Avatar.currentAvatar != null && Vector3.Distance(transform.position, Avatar.currentAvatar.transform.position) <= range) {
            animator.SetTrigger("Attack");

            Vector3 targetPos = new Vector3(
                Avatar.currentAvatar.transform.position.x,
                transform.position.y,
                Avatar.currentAvatar.transform.position.z);
            transform.LookAt(targetPos, Vector3.up);
        }
    }

    //llamado desde animacion
    public void SpawnBullet() {
        if(Avatar.currentAvatar == null)
            return;

        EnemyBullet newBullet = Instantiate<EnemyBullet>(bulletPrefab);
        newBullet.transform.position = (bulletOrigin != null) ? bulletOrigin.position : transform.position;

        Vector3 targetPos = new Vector3(
            Avatar.currentAvatar.transform.position.x,
            newBullet.transform.position.y,
            Avatar.currentAvatar.transform.position.z);
        newBullet.transform.LookAt(targetPos, Vector3.up);

        Debug.DrawLine(transform.position, Avatar.currentAvatar.transform.position, Color.red, 0.1f);
    }

    private void OnDrawGizmosSelected() {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, range);
    }
}
