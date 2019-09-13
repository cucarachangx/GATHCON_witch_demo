using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Level : MonoBehaviour
{
    [HideInInspector]
    public List<Enemy> enemies = new List<Enemy>();

    public Transform avatarSpawn = null;
    public LevelGoal levelGoal = null;

    private void Start() {
        if(Avatar.currentAvatar != null) {
            Avatar.currentAvatar.transform.position = avatarSpawn.transform.position;
        }
    }

    public void EnemySpawned(Enemy enemy) {
        if(!enemies.Contains(enemy))
            enemies.Add(enemy);
    }
    public void EnemyDead(Enemy enemy) {
        enemies.Remove(enemy);
        if(enemies.Count == 0)
            AllEnemiesDead();
    }

    void AllEnemiesDead() {
        levelGoal.Open();
        EventDispatcher.AllEnemiesDead();
    }

    public void AvatarReachesTheGoal() {
        LevelsController.GetInstance().LevelCompleted();
    }

    private void OnDrawGizmos() {
        Gizmos.color = Color.magenta;
        if(avatarSpawn)
            Gizmos.DrawCube(avatarSpawn.transform.position, Vector3.one);
        Gizmos.color = Color.yellow;
        if(levelGoal)
            Gizmos.DrawCube(levelGoal.transform.position, Vector3.one);
    }
}
