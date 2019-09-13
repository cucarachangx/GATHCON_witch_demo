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

    [SerializeField]
    AvatarHealth avatarH;


    void Start() {
        avatarH.SetUpMaxHealth(life);
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
        avatarH.ChangeHealth(life);
        animator.SetTrigger("TakeDamage");

        if(life <= 0) {
            Die();
        }

        return true;
    }

    public void AddHealth(float amount) {
        life += amount;
        avatarH.ChangeHealth(life);
        animator.SetTrigger("Health");
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
