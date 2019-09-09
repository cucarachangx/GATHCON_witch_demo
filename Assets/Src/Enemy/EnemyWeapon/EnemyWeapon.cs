using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyWeapon : MonoBehaviour {
    public float cooldown = 0.5f;
    public float range = 3f;

    [Space]
    [SerializeField] EnemyBullet bulletPrefab = null;

    float cooldownTimer = 0f;

    // Update is called once per frame
    void Update() {
        cooldownTimer -= Time.deltaTime;
        if(cooldownTimer <= 0) {
            Shoot();
            cooldownTimer = cooldown;
        }
    }

    public void Shoot() {
        Avatar avatar = Avatar.currentAvatar;

        if(avatar != null && Vector3.Distance(transform.position, avatar.transform.position) <= range) {
            EnemyBullet newBullet = Instantiate<EnemyBullet>(bulletPrefab);
            newBullet.transform.position = transform.position;
            newBullet.transform.LookAt(avatar.transform, Vector3.up);
            Debug.DrawLine(transform.position, avatar.transform.position, Color.red, 0.1f);
        }
    }

    private void OnDrawGizmosSelected() {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, range);
    }
}
