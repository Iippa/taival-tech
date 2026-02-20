import https from 'https';
import fs from 'fs';
import path from 'path';

const API_KEY = process.env.OPENAI_API_KEY;
const OUT_DIR = './images';
fs.mkdirSync(OUT_DIR, { recursive: true });

const prompts = [
  {
    file: 'hero.png',
    prompt: 'Precision CNC-machined aluminum aerospace component on a clean matte black surface, professional product photography, studio lighting, ultra sharp, photorealistic, no people, no text'
  },
  {
    file: 'engineering.png',
    prompt: 'Close-up of a complex printed circuit board with fine traces, gold contacts and black IC chips, macro photography, dark background, high detail, photorealistic'
  },
  {
    file: 'process.png',
    prompt: 'Modern industrial design studio, two engineers reviewing a 3D CAD model on large monitors showing mechanical assembly, natural side lighting, clean workspace, cinematic, photorealistic'
  }
];

async function generateImage(prompt, filename) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify({
      model: 'gpt-image-1',
      prompt,
      n: 1,
      size: '1536x1024',
      quality: 'high',
      output_format: 'png'
    });

    const options = {
      hostname: 'api.openai.com',
      path: '/v1/images/generations',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_KEY}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body)
      }
    };

    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          if (json.data && json.data[0].b64_json) {
            const buf = Buffer.from(json.data[0].b64_json, 'base64');
            fs.writeFileSync(path.join(OUT_DIR, filename), buf);
            console.log(`✓ ${filename}`);
            resolve();
          } else {
            console.error('Error:', JSON.stringify(json));
            reject(new Error(JSON.stringify(json)));
          }
        } catch(e) { reject(e); }
      });
    });
    req.on('error', reject);
    req.write(body);
    req.end();
  });
}

for (const p of prompts) {
  await generateImage(p.prompt, p.file);
}
console.log('All images done.');
