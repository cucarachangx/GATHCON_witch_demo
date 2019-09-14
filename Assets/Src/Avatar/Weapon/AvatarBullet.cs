using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarBullet : MonoBehaviour
{
    public float speed = 30f;
    public float lifeTime = 3f;
    public float damage = 1;

    float lifeTimer = 0f;

    private void Start() {
        lifeTimer = lifeTime;
        GetComponent<Rigidbody>().velocity = transform.forward * speed;
    }

    // Update is called once per frame
    void Update() {

        lifeTimer -= Time.deltaTime;
        if(lifeTimer <= 0) {
            Destroy(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other) {
        AvatarWeaponTarget avatarWeaponTarget = other.GetComponent<AvatarWeaponTarget>();
        if(avatarWeaponTarget != null) {

            avatarWeaponTarget.ReceiveImpact(this);
        }
        Destroy(gameObject);
    }
}
