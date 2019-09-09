using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour
{
    public static Avatar currentAvatar = null;

    public float life = 10;

    AvatarMovement movementComp = null;
    AvatarWeapon weaponComp = null;
    Animator animator = null;

    // Start is called before the first frame update
    void Start() {
        movementComp = GetComponent<AvatarMovement>();
        weaponComp = GetComponent<AvatarWeapon>();
        animator = GetComponent<Animator>();
        currentAvatar = this;
    }

    void LateUpdate() {
        weaponComp.SetShooting(!movementComp.moving);
    }

    public bool ReceiveImpact(EnemyBullet bullet) {
        life -= bullet.damage;
        animator.SetTrigger("TakeDamage");

        if(life <= 0) {
            Die();
        }

        return true;
    }

    void Die() {
        animator.SetTrigger("Dead");
        Destroy(gameObject, 1f);

        GetComponent<Collider>().enabled = false;
        weaponComp.enabled = false;
        movementComp.enabled = false;
    }

    void ReceiveLife()
    {
        animator.SetTrigger("Health");
    }

    private void OnDestroy() {
        currentAvatar = null;
    }
}
