using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBullet : MonoBehaviour
{
    public float speed = 30f;
    public float lifeTime = 3f;
    public float damage = 1;

    float lifeTimer = 0f;
    [Space]
    [SerializeField] GameObject onGrabFxPrefab = null;

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
        Avatar avatar = other.GetComponent<Avatar>();
        if(avatar != null) {
            avatar.ReceiveImpact(this);
            GameObject fx = Instantiate<GameObject>(onGrabFxPrefab, avatar.transform.position, Quaternion.identity);
            Destroy(fx, 1f);
        }
        Destroy(gameObject);
    }
}
