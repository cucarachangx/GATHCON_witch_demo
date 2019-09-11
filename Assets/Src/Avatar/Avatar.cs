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
    [SerializeField]
    GameObject poisonBottle;
    [SerializeField]
    GameObject loveBottle;

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
        avatarH.ChangeHealth(life);
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

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.Equals(poisonBottle))
        {
            this.transform.GetChild(3).gameObject.SetActive(true);
            other.gameObject.SetActive(false);
        }
        else
        {
            if (other.gameObject.Equals(loveBottle))
            {
                this.transform.GetChild(4).gameObject.SetActive(true);
                other.gameObject.SetActive(false);
            }
        }
    }
}
