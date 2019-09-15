using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelsController : Singleton<LevelsController>
{
    public Level currenLevel { get; private set; }
    public static int levelIndex = 0;

    [SerializeField] Level[] levelPrefabs = null;

    protected override void Awake() {
        base.Awake();

        Level levelInScene = FindObjectOfType<Level>();
        if(levelInScene != null) {
            currenLevel = levelInScene;
        }
        else {
            currenLevel = GenerateNewLevel();
        }
    }


    Level GenerateNewLevel(int lvlIdx = 0) {
        Level newLevel = Instantiate<Level>(levelPrefabs[lvlIdx]);

        return newLevel;
    }

    void DestroyCurrentLevel() {
        Destroy(currenLevel.gameObject);
        currenLevel = null;
    }

    public void LevelCompleted() {
        levelIndex++;
        UnityEngine.SceneManagement.SceneManager.LoadScene(levelIndex);
        //TODO: arreglar esto, que funcione el paso de niveles

        return;
        DestroyCurrentLevel();
        levelIndex++;
        if(levelIndex >= levelPrefabs.Length)
            levelIndex = 0;
        currenLevel = GenerateNewLevel(levelIndex);
    }
}
