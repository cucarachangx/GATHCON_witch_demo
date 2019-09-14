using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public float life = 10;
    public float bulletDamage;
    public bool inmortal = false;


    EnemyWeapon weaponComp = null;
    Animator animator = null;

    [SerializeField]
    AvatarHealth healthBarScr;

    // Start is called before the first frame update
    void Start() {
        healthBarScr.SetUpMaxHealth(life);
        weaponComp = GetComponent<EnemyWeapon>();
        animator = GetComponent<Animator>();

        if(LevelsController.GetInstance() != null && LevelsController.GetInstance().currenLevel != null) {
            LevelsController.GetInstance().currenLevel.EnemySpawned(this);
        }
    }

    public void ReceiveAvatarBulletImpact(AvatarBullet bullet) {

        if(!inmortal) {
            animator.SetTrigger("TakeDamage");
            life -= bullet.damage;
            healthBarScr.ChangeHealth(life);
            if (life <= 0)
                Die();
        }

        //TODO: animacion de hit
    }

    public void Die() {
        GetComponent<Rigidbody>().isKinematic = true;
        animator.SetTrigger("Dead");
        Destroy(gameObject, 1f);

        GetComponent<AvatarWeaponTarget>().enabled = false;
        GetComponent<Collider>().enabled = false;
        weaponComp.enabled = false;

        if(LevelsController.GetInstance() != null && LevelsController.GetInstance().currenLevel != null) {
            LevelsController.GetInstance().currenLevel.EnemyDead(this);
        }
    }
}
