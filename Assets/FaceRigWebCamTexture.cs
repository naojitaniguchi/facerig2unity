//
// FaceRigWebCamTexture 使用例 by GOROman
//
using UnityEngine;
using System.Collections;
using System.IO;
public class FaceRigWebCamTexture : MonoBehaviour
{
	// Virtualカメラの名前
	public string cameraName = "FaceRig Virtual Camera";
	public int Width = 1280;
	public int Height = 720;
	public int FPS = 60;
	public Material material = null;
	private WebCamTexture webcamTexture;
	void Start()
	{
		// WebCameraの列挙と取得
		webcamTexture = FindWebCameraByName(cameraName);
		if (webcamTexture != null)
		{
			// マテリアルが指定されていない場合はGameObjectから自動取得
			if (material == null)
			{
				material = gameObject.GetComponent<Renderer>().material;
			}
			// テクスチャをWebCamTextureとして設定
			material.mainTexture = webcamTexture;
			// WebCamTextureの再生を開始
			webcamTexture.Play();
		}
		else
		{
			Debug.LogWarning("Could not find " + cameraName);
		}
	}
	// ウェブカメラテクスチャをカメラ名から得る
	private WebCamTexture FindWebCameraByName(string cameraNname)
	{
		// ウェブカメラデバイスを得る
		WebCamDevice[] devices = WebCamTexture.devices;
		WebCamTexture webcamtexture = null;
		// ウェブカメラの列挙
		for (var i = 0; i < devices.Length; i++)
		{
			// ウェブカメラ名を取得
			string name = devices[i].name;
			print(i + ":" + name);
			// 一致したか?
			if (cameraName == name)
			{
				// ウェブカメラテクスチャを生成
				return new WebCamTexture(cameraName, Width, Height, FPS);
			}
		}
		return null;
	}
}
