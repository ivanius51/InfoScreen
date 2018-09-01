--[[
-----------------------------------------------
  ______     __   _____                _        _____ _____ __ 
 |  _ \ \   / /  |_   _|              (_)      / ____| ____/_ |
 | |_) \ \_/ /     | |_   ____ _ _ __  _ _   _| (___ | |__  | |
 |  _ < \   /      | \ \ / / _` | '_ \| | | | |\___ \|___ \ | |
 | |_) | | |      _| |\ V / (_| | | | | | |_| |____) |___) || |
 |____/  |_|     |_____\_/ \__,_|_| |_|_|\__,_|_____/|____/ |_|
                                                               
http://GetScript.Net
-----------------------End---------------------
Is licensed under the
GNU General Public License v3.0

----------------------TODO---------------------
InfoScreen:
  Missing Hero
  Courier Info
  Hiden Entity last

  concat with skill alert script?
  buffs\debuffs on hero - show overhero +-
  Visible By Enemy to skill alert
  Life Time Ward +-

ItemPanel:


EnemyTeamStatus panel :
  1)Add more important skills(nimbus, metamarphose)\items (refresher) or add all skills customization
  

  Timers in time foramt
----------------------READY---------------------
HP, MP bars with current count - made
ItemPanel Item Count \ Cooldown

--]]
local InfoScreen = {};


--PERFORMANCE
local ceil = math.ceil;
local floor = math.floor;
local fmod = math.fmod;
--objects
local GameTime = 0;
local UpdateCount = 0;
local User = nil;
--lists
InfoScreen.Menu = {};
InfoScreen.Particles = {};
InfoScreen.Images = {};
InfoScreen.Renderer = {};
local Global = {};
Global.EnemyHeroes = {};
Global.Skills = {};
Global.Items = {};
Global.Abilities = {};

local HeroInfo = {

  --Strength Heroes--
  
  npc_dota_hero_abaddon = {
  AttackTime = 1.7,
  AttackPoint = 0.56,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.5,
  AttackBackSwing = 0.41},
  
  npc_dota_hero_alchemist = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 150,
  MovementSpeed = 290,
  TurnRate = 0.6,
  AttackBackSwing = 0.65},
  
  npc_dota_hero_axe = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 290,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_beastmaster = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_brewmaster = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.65},
  
  npc_dota_hero_bristleback = {
  AttackTime = 1.8,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 1.0,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_centaur = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_chaos_knight = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 320,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_rattletrap = {
  AttackTime = 1.7,
  AttackPoint = 0.33,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 0.6,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_doom_bringer = {
  AttackTime = 2.0,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_dragon_knight = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_earth_spirit = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.65},
  
  npc_dota_hero_earthshaker = {
  AttackTime = 1.7,
  AttackPoint = 0.467,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.9,
  AttackBackSwing = 0.863},
  
  npc_dota_hero_elder_titan = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 0.5,
  AttackBackSwing = 0.97},
  
  npc_dota_hero_huskar = {
  AttackTime = 1.6,
  AttackPoint = 0.4,
  AttackRange = 400,
  ProjectileSpeed = 1400,
  MovementSpeed = 290,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_wisp = {
  AttackTime = 1.7,
  AttackPoint = 0.15,
  AttackRange = 575,
  ProjectileSpeed = 1200,
  MovementSpeed = 290,
  TurnRate = 0.7,
  AttackBackSwing = 0.4},
  
  npc_dota_hero_kunkka = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_legion_commander = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 150,
  MovementSpeed = 315,
  TurnRate = 0.5,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_life_stealer = {
  AttackTime = 1.85,
  AttackPoint = 0.39,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 1.0,
  AttackBackSwing = 0.44},
  
  npc_dota_hero_lycan = {
  AttackTime = 1.7,
  AttackPoint = 0.55,
  AttackRange = 150,
  MovementSpeed = 300,
  TurnRate = 0.5,
  AttackBackSwing = 0.55},
  
  npc_dota_hero_magnataur = {
  AttackTime = 1.8,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.8,
  AttackBackSwing = 0.84},
  
  npc_dota_hero_night_stalker = {
  AttackTime = 1.7,
  AttackPoint = 0.55,
  AttackRange = 150,
  MovementSpeed = 290,
  TurnRate = 0.5,
  AttackBackSwing = 0.55},
  
  npc_dota_hero_omniknight = {
  AttackTime = 1.7,
  AttackPoint = 0.433,
  AttackRange = 150,
  MovementSpeed = 300,
  TurnRate = 0.6,
  AttackBackSwing = 0.567},
  
  npc_dota_hero_phoenix = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 500,
  ProjectileSpeed = 1100,
  MovementSpeed = 280,
  TurnRate = 1.0,
  AttackBackSwing = 0.633},
  
  npc_dota_hero_pudge = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 275,
  TurnRate = 0.7,
  AttackBackSwing = 1.17},
  
  npc_dota_hero_sand_king = {
  AttackTime = 1.7,
  AttackPoint = 0.53,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.47},
  
  npc_dota_hero_slardar = {
  AttackTime = 1.7,
  AttackPoint = 0.36,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_spirit_breaker = {
  AttackTime = 1.9,
  AttackPoint = 0.6,
  AttackRange = 150,
  MovementSpeed = 280,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_sven = {
  AttackTime = 1.8,
  AttackPoint = 0.4,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_tidehunter = {
  AttackTime = 1.7,
  AttackPoint = 0.6,
  AttackRange = 150,
  MovementSpeed = 300,
  TurnRate = 0.5,
  AttackBackSwing = 0.56},
  
  npc_dota_hero_shredder = {
  AttackTime = 1.7,
  AttackPoint = 0.36,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_tiny = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 150,
  MovementSpeed = 280,
  TurnRate = 0.5,
  AttackBackSwing = 1},
  
  npc_dota_hero_treant = {
  AttackTime = 1.9,
  AttackPoint = 0.6,
  AttackRange = 150,
  MovementSpeed = 265,
  TurnRate = 0.5,
  AttackBackSwing = 0.4},
  
  npc_dota_hero_tusk = {
  AttackTime = 1.7,
  AttackPoint = 0.36,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.7,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_abyssal_underlord = {
  AttackTime = 1.7,
  AttackPoint = 0.45,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_undying = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_skeleton_king = {
  AttackTime = 1.7,
  AttackPoint = 0.56,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.44},
  
  --Agility Heroes--
  
  npc_dota_hero_antimage = {
  AttackTime = 1.45,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 0.5,
  AttackBackSwing = 0.6},
  
  npc_dota_hero_arc_warden = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 625,
  ProjectileSpeed = 900,
  MovementSpeed = 280,
  TurnRate = 0.6,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_bloodseeker = {
  AttackTime = 1.7,
  AttackPoint = 0.43,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.74},
  
  npc_dota_hero_bounty_hunter = {
  AttackTime = 1.7,
  AttackPoint = 0.59,
  AttackRange = 150,
  MovementSpeed = 315,
  TurnRate = 0.6,
  AttackBackSwing = 0.59},
  
  npc_dota_hero_broodmother = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 150,
  MovementSpeed = 270,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_clinkz = {
  AttackTime = 1.7,
  AttackPoint = 0.7,
  AttackRange = 640,
  ProjectileSpeed = 900,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_drow_ranger = {
  AttackTime = 1.7,
  AttackPoint = 0.7,
  AttackRange = 625,
  ProjectileSpeed = 1250,
  MovementSpeed = 285,
  TurnRate = 0.7,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_ember_spirit = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_faceless_void = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 1,
  AttackBackSwing = 0.56},
  
  npc_dota_hero_gyrocopter = {
  AttackTime = 1.7,
  AttackPoint = 0.2,
  AttackRange = 365,
  ProjectileSpeed = 3000,
  MovementSpeed = 320,
  TurnRate = 0.6,
  AttackBackSwing = 0.97},
  
  npc_dota_hero_juggernaut = {
  AttackTime = 1.4,
  AttackPoint = 0.33,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.84},
  
  npc_dota_hero_lone_druid = {
  AttackTime = 1.7,
  AttackPoint = 0.33,
  AttackRange = 550,
  ProjectileSpeed = 900,
  MovementSpeed = 320,
  TurnRate = 0.5,
  AttackBackSwing = 0.53},
  
  npc_dota_hero_luna = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 330,
  ProjectileSpeed = 900,
  MovementSpeed = 330,
  TurnRate = 0.6,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_medusa = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 600,
  ProjectileSpeed = 1200,
  MovementSpeed = 275,
  TurnRate = 0.5,
  AttackBackSwing = 0.6},
  
  npc_dota_hero_meepo = {
  AttackTime = 1.7,
  AttackPoint = 0.38,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 0.65,
  AttackBackSwing = 0.6},
  
  npc_dota_hero_mirana = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 630,
  ProjectileSpeed = 900,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_monkey_king = {
  AttackTime = 1.7,
  AttackPoint = 0.45,
  AttackRange = 300,
  MovementSpeed = 300,
  TurnRate = 0.6,
  AttackBackSwing = 0.2},
  
  npc_dota_hero_morphling = {
  AttackTime = 1.5,
  AttackPoint = 0.5,
  AttackRange = 350,
  ProjectileSpeed = 1300,
  MovementSpeed = 280,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_naga_siren = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 315,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_nyx_assassin = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_pangolier = {
  AttackTime = 1.7,
  AttackPoint = 0.33,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 1,
  AttackBackSwing = 0},
  
  npc_dota_hero_phantom_assassin = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.6,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_phantom_lancer = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_razor = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 475,
  ProjectileSpeed = 2000,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_riki = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 275,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_nevermore = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 500,
  ProjectileSpeed = 1200,
  MovementSpeed = 310,
  TurnRate = 1.0,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_slark = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_sniper = {
  AttackTime = 1.7,
  AttackPoint = 0.17,
  AttackRange = 550,
  ProjectileSpeed = 3000,
  MovementSpeed = 285,
  TurnRate = 0.7,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_spectre = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_templar_assassin = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 140,
  ProjectileSpeed = 900,
  MovementSpeed = 310,
  TurnRate = 0.7,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_terrorblade = {
  AttackTime = 1.5,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 310,
  TurnRate = 0.5,
  AttackBackSwing = 0.6},
  
  npc_dota_hero_troll_warlord = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 500,
  ProjectileSpeed = 1200,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_ursa = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 305,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_vengefulspirit = {
  AttackTime = 1.7,
  AttackPoint = 0.33,
  AttackRange = 400,
  ProjectileSpeed = 1500,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.64},
  
  npc_dota_hero_venomancer = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 450,
  ProjectileSpeed = 900,
  MovementSpeed = 275,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_viper = {
  AttackTime = 1.7,
  AttackPoint = 0.33,
  AttackRange = 575,
  ProjectileSpeed = 1200,
  MovementSpeed = 275,
  TurnRate = 0.5,
  AttackBackSwing = 1},
  
  npc_dota_hero_weaver = {
  AttackTime = 1.8,
  AttackPoint = 0.64,
  AttackRange = 425,
  ProjectileSpeed = 900,
  MovementSpeed = 280,
  TurnRate = 0.5,
  AttackBackSwing = 0.36},
  
  --Intelligence Heroes--
  
  npc_dota_hero_ancient_apparition = {
  AttackTime = 1.7,
  AttackPoint = 0.45,
  AttackRange = 675,
  ProjectileSpeed = 1250,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_bane = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 400,
  ProjectileSpeed = 900,
  MovementSpeed = 310,
  TurnRate = 0.6,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_batrider = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 375,
  ProjectileSpeed = 900,
  MovementSpeed = 290,
  TurnRate = 1.0,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_chen = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 650,
  ProjectileSpeed = 1100,
  MovementSpeed = 310,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_crystal_maiden = {
  AttackTime = 1.7,
  AttackPoint = 0.55,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 275,
  TurnRate = 0.5,
  AttackBackSwing = 0},
  
  npc_dota_hero_dark_seer = {
  AttackTime = 1.7,
  AttackPoint = 0.59,
  AttackRange = 150,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.58},
  
  npc_dota_hero_dark_willow = {
  AttackTime = 1.3,
  AttackPoint = 0.3,
  AttackRange = 475,
  ProjectileSpeed = 1200,
  MovementSpeed = 295,
  TurnRate = 0.7,
  AttackBackSwing = 0},
  
  npc_dota_hero_dazzle = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 550,
  ProjectileSpeed = 1200,
  MovementSpeed = 310,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_death_prophet = {
  AttackTime = 1.7,
  AttackPoint = 0.56,
  AttackRange = 600,
  ProjectileSpeed = 1000,
  MovementSpeed = 310,
  TurnRate = 0.5,
  AttackBackSwing = 0.51},
  
  npc_dota_hero_disruptor = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 1200,
  MovementSpeed = 300,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_enchantress = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 550,
  ProjectileSpeed = 900,
  MovementSpeed = 340,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_enigma = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 500,
  ProjectileSpeed = 900,
  MovementSpeed = 300,
  TurnRate = 0.5,
  AttackBackSwing = 0.77},
  
  npc_dota_hero_invoker = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 280,
  TurnRate = 0.5,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_jakiro = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 400,
  ProjectileSpeed = 1100,
  MovementSpeed = 290,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_keeper_of_the_light = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 335,
  TurnRate = 0.5,
  AttackBackSwing = 0.85},
  
  npc_dota_hero_leshrac = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 330,
  TurnRate = 0.5,
  AttackBackSwing = 0.77},
  
  npc_dota_hero_lich = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 550,
  ProjectileSpeed = 900,
  MovementSpeed = 315,
  TurnRate = 0.5,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_lina = {
  AttackTime = 1.6,
  AttackPoint = 0.75,
  AttackRange = 670,
  ProjectileSpeed = 1000,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.78},
  
  npc_dota_hero_lion = {
  AttackTime = 1.7,
  AttackPoint = 0.43,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 290,
  TurnRate = 0.5,
  AttackBackSwing = 0.74},
  
  npc_dota_hero_furion = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 1125,
  MovementSpeed = 290,
  TurnRate = 0.6,
  AttackBackSwing = 0.77},
  
  npc_dota_hero_necrolyte = {
  AttackTime = 1.7,
  AttackPoint = 0.45,
  AttackRange = 550,
  ProjectileSpeed = 900,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.47},
  
  npc_dota_hero_ogre_magi = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 150,
  MovementSpeed = 285,
  TurnRate = 0.6,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_oracle = {
  AttackTime = 1.4,
  AttackPoint = 0.3,
  AttackRange = 620,
  ProjectileSpeed = 900,
  MovementSpeed = 305,
  TurnRate = 0.7,
  AttackBackSwing = 0.7},
  
  npc_dota_hero_obsidian_destroyer = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 450,
  ProjectileSpeed = 900,
  MovementSpeed = 315,
  TurnRate = 0.5,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_puck = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 550,
  ProjectileSpeed = 900,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.8},
  
  npc_dota_hero_pugna = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 630,
  ProjectileSpeed = 900,
  MovementSpeed = 335,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_queenofpain = {
  AttackTime = 1.5,
  AttackPoint = 0.56,
  AttackRange = 550,
  ProjectileSpeed = 1500,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.41},
  
  npc_dota_hero_rubick = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 550,
  ProjectileSpeed = 1125,
  MovementSpeed = 290,
  TurnRate = 0.7,
  AttackBackSwing = 0.77},
  
  npc_dota_hero_shadow_demon = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 500,
  ProjectileSpeed = 900,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_shadow_shaman = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 400,
  ProjectileSpeed = 900,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_silencer = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 600,
  ProjectileSpeed = 1000,
  MovementSpeed = 295,
  TurnRate = 0.6,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_skywrath_mage = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 1000,
  MovementSpeed = 330,
  TurnRate = 0.5,
  AttackBackSwing = 0.78},
  
  npc_dota_hero_storm_spirit = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 480,
  ProjectileSpeed = 1100,
  MovementSpeed = 285,
  TurnRate = 0.8,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_techies = {
  AttackTime = 1.7,
  AttackPoint = 0.5,
  AttackRange = 700,
  ProjectileSpeed = 900,
  MovementSpeed = 270,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_tinker = {
  AttackTime = 1.7,
  AttackPoint = 0.35,
  AttackRange = 500,
  ProjectileSpeed = 900,
  MovementSpeed = 290,
  TurnRate = 0.6,
  AttackBackSwing = 0.65},
  
  npc_dota_hero_visage = {
  AttackTime = 1.7,
  AttackPoint = 0.46,
  AttackRange = 600,
  ProjectileSpeed = 900,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.54},
  
  npc_dota_hero_warlock = {
  AttackTime = 1.7,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 1200,
  MovementSpeed = 295,
  TurnRate = 0.5,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_windrunner = {
  AttackTime = 1.5,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 1250,
  MovementSpeed = 295,
  TurnRate = 0.8,
  AttackBackSwing = 0.3},
  
  npc_dota_hero_winter_wyvern = {
  AttackTime = 1.7,
  AttackPoint = 0.25,
  AttackRange = 425,
  ProjectileSpeed = 700,
  MovementSpeed = 285,
  TurnRate = 0.5,
  AttackBackSwing = 0.8},
  
  npc_dota_hero_witch_doctor = {
  AttackTime = 1.7,
  AttackPoint = 0.4,
  AttackRange = 600,
  ProjectileSpeed = 1200,
  MovementSpeed = 305,
  TurnRate = 0.5,
  AttackBackSwing = 0.5},
  
  npc_dota_hero_zuus = {
  AttackTime = 1.7,
  AttackPoint = 0.633,
  AttackRange = 380,
  ProjectileSpeed = 1100,
  MovementSpeed = 300,
  TurnRate = 0.6,
  AttackBackSwing = 0.366},
  
  --Non Hero Units--
  
  npc_dota_lone_druid_bear1 = {
  AttackTime = 1.65,
  AttackPoint = 0.43,
  AttackRange = 128,
  AttackBackSwing = 0.67},
  
  npc_dota_lone_druid_bear2 = {
  AttackTime = 1.55,
  AttackPoint = 0.43,
  AttackRange = 128,
  AttackBackSwing = 0.67},
  
  npc_dota_lone_druid_bear3 = {
  AttackTime = 1.45,
  AttackPoint = 0.43,
  AttackRange = 128,
  AttackBackSwing = 0.67},
  
  npc_dota_lone_druid_bear4 = {
  AttackTime = 1.35,
  AttackPoint = 0.43,
  AttackRange = 128,
  AttackBackSwing = 0.67},
  
  npc_dota_creep_badguys_melee = {
  AttackTime = 1,
  AttackPoint = 0.467,
  AttackRange = 100,
  AttackBackSwing = 0.533},
  
  npc_dota_creep_goodguys_melee = {
  AttackTime = 1,
  AttackPoint = 0.467,
  AttackRange = 100,
  AttackBackSwing = 0.533},
  
  npc_dota_creep_badguys_ranged = {
  AttackTime = 1,
  AttackPoint = 0.5,
  AttackRange = 500,
  ProjectileSpeed = 900,
  AttackBackSwing = 0.3},
  
  npc_dota_creep_goodguys_ranged	= {
  AttackTime = 1,
  AttackPoint = 0.5,
  AttackRange = 500,
  ProjectileSpeed = 900,
  AttackBackSwing = 0.3},
  
  npc_dota_badguys_siege = {
  AttackTime = 2.7,
  AttackPoint = 0.7,
  AttackRange = 690,
  ProjectileSpeed = 1100,
  AttackBackSwing = 2.0},
  
  npc_dota_goodguys_siege = {
  AttackTime = 2.7,
  AttackPoint = 0.7,
  AttackRange = 690,
  ProjectileSpeed = 1100,
  AttackBackSwing = 2.0},
  
  npc_dota_venomancer_plague_ward_1 = {
  AttackTime = 1.5,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 1900,
  AttackBackSwing = 0.7},
  
  npc_dota_venomancer_plague_ward_2 = {
  AttackTime = 1.5,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 1900,
  AttackBackSwing = 0.7},
  
  npc_dota_venomancer_plague_ward_3 = {
  AttackTime = 1.5,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 1900,
  AttackBackSwing = 0.7},
  
  npc_dota_venomancer_plague_ward_4 = {
  AttackTime = 1.5,
  AttackPoint = 0.3,
  AttackRange = 600,
  ProjectileSpeed = 1900,
  AttackBackSwing = 0.7},
  
  npc_dota_badguys_tower1_bot = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower1_mid = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower1_top = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower2_bot = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower2_mid = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower2_top = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower3_bot = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower3_mid = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower3_top = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_badguys_tower4 = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower1_bot = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower1_mid = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower1_top = {
  AttackTime = 1,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower2_bot = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower2_mid = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower2_top = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower3_bot = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower3_mid = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower3_top = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_goodguys_tower4 = {
  AttackTime = 0.95,
  AttackPoint = 0.6,
  AttackRange = 700,
  ProjectileSpeed = 750,
  AttackBackSwing = 0.4},
  
  npc_dota_invoker_forged_spirit = {
  AttackTime = 1.5,
  AttackPoint = 0.2,
  AttackRange = 900,
  ProjectileSpeed = 1000,
  AttackBackSwing = 0.4},
  
  npc_dota_lycan_wolf1 = {
  AttackTime = 1.2,
  AttackPoint = 0.33,
  AttackBackSwing = 0.64},
  
  npc_dota_lycan_wolf2 = {
  AttackTime = 1.1,
  AttackPoint = 0.33,
  AttackBackSwing = 0.64},
  
  npc_dota_lycan_wolf3 = {
  AttackTime = 1,
  AttackPoint = 0.33,
  AttackBackSwing = 0.64},
  
  npc_dota_lycan_wolf4 = {
  AttackTime = 0.9,
  AttackPoint = 0.33,
  AttackBackSwing = 0.64},
  
  npc_dota_brewmaster_earth_1 = {
  AttackTime = 1.25,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_earth_2 = {
  AttackTime = 1.25,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_earth_3 = {
  AttackTime = 1.25,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_fire_1 = {
  AttackTime = 1.35,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_fire_2 = {
  AttackTime = 1.35,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_fire_3 = {
  AttackTime = 1.35,
  AttackPoint = 0.3,
  AttackBackSwing = 0.3},
  
  npc_dota_brewmaster_storm_1 = {
  AttackTime = 1.5,
  AttackPoint = 0.4,
  AttackBackSwing = 0.77},
  
  npc_dota_brewmaster_storm_2 = {
  AttackTime = 1.5,
  AttackPoint = 0.4,
  AttackBackSwing = 0.77},
  
  npc_dota_brewmaster_storm_3 = {
  AttackTime = 1.5,
  AttackPoint = 0.4,
  AttackBackSwing = 0.77},
  
  npc_dota_necronomicon_archer_1 = {
  AttackTime = 1,
  AttackPoint = 0.7,
  AttackBackSwing = 0.3},
  
  npc_dota_necronomicon_archer_2 = {
  AttackTime = 1,
  AttackPoint = 0.7,
  AttackBackSwing = 0.3},
  
  npc_dota_necronomicon_archer_3 = {
  AttackTime = 1,
  AttackPoint = 0.7,
  AttackBackSwing = 0.3},
  
  npc_dota_necronomicon_warrior_1 = {
  AttackTime = 0.75,
  AttackPoint = 0.56,
  AttackBackSwing = 0.44},
  
  npc_dota_necronomicon_warrior_2 = {
  AttackTime = 0.75,
  AttackPoint = 0.56,
  AttackBackSwing = 0.44},
  
  npc_dota_necronomicon_warrior_3 = {
  AttackTime = 0.75,
  AttackPoint = 0.56,
  AttackBackSwing = 0.44},
  
  npc_dota_beastmaster_boar = {
  AttackTime = 1.25,
  AttackPoint = 0.5,
  AttackBackSwing = 0.47},
  
  npc_dota_beastmaster_greater_boar = {
  AttackTime = 1.25,
  AttackPoint = 0.5,
  AttackBackSwing = 0.47},
  
  npc_dota_visage_familiar1 = {
  AttackTime = 0.4,
  AttackPoint = 0.33,
  AttackBackSwing = 0.2},
  
  npc_dota_visage_familiar2 = {
  AttackTime = 0.4,
  AttackPoint = 0.33,
  AttackBackSwing = 0.2},
  
  npc_dota_visage_familiar3 = {
  AttackTime = 0.4,
  AttackPoint = 0.33,
  AttackBackSwing = 0.2},
  
  };


function table.tostring(list)
	local result = "{";
	for k, v in pairs(list) do
			-- Check the key type (ignore any numerical keys - assume its an array)
			if type(k) == "string" then
					result = result.."[\""..k.."\"]".."=";
			end;

			-- Check the value type
			if type(v) == "table" then
					result = result..table.tostring(v);
			elseif type(v) == "boolean" then
					result = result..tostring(v);
			else
					result = result.."\""..v.."\"";
			end;
			result = result..",";
	end;
	-- Remove leading commas from the result
	if result ~= "" then
			result = result:sub(1, result:len()-1);
	end;
	return result.."}";
end;

function RoundNumber(num, idp)
	local mult = 10^(idp or 0);
	return floor(num * mult + 0.5) / mult;
end

function dispTime(time)
  --local hours = floor(fmod(time, 86400)/3600)
  local minutes = floor(fmod(time,3600)/60)
  local seconds = floor(fmod(time,60))
  return string.format("%02d:%02d",minutes,seconds)
end

InfoScreen.PseudoData = {};

InfoScreen.PseudoData.ChanseTable = {
  [5] = 0.003802,
  [6] = 0.005440,
  [7] = 0.007359,
  [8] = 0.009552,
  [9] = 0.012016,
  [10] = 0.014746,
  [11] = 0.017736,
  [12] = 0.020983,
  [13] = 0.024482,
  [14] = 0.028230,
  [15] = 0.032221,
  [16] = 0.036452,
  [17] = 0.040920,
  [18] = 0.045620,
  [19] = 0.050549,
  [20] = 0.055704,
  [21] = 0.061081,
  [22] = 0.066676,
  [23] = 0.072488,
  [24] = 0.078511,
  [25] = 0.084744,
  [26] = 0.091183,
  [27] = 0.097826,
  [28] = 0.104670,
  [29] = 0.111712,
  [30] = 0.118949,
  [31] = 0.126379,
  [32] = 0.134001,
  [33] = 0.141805,
  [34] = 0.149810,
  [35] = 0.157983,
  [36] = 0.166329,
  [37] = 0.174909,
  [38] = 0.183625,
  [39] = 0.192486,
  [40] = 0.201547,
  [41] = 0.210920,
  [42] = 0.220365,
  [43] = 0.229899,
  [44] = 0.239540,
  [45] = 0.249307,
  [46] = 0.259872,
  [47] = 0.270453,
  [48] = 0.281008,
  [49] = 0.291552,
  [50] = 0.302103,
  [51] = 0.312677,
  [52] = 0.323291,
  [53] = 0.334120,
  [54] = 0.347370,
  [55] = 0.360398,
  [56] = 0.373217,
  [57] = 0.385840,
  [58] = 0.398278,
  [59] = 0.410545,
  [60] = 0.422650,
  [61] = 0.434604,
  [62] = 0.446419,
  [63] = 0.458104,
  [64] = 0.469670,
  [65] = 0.481125,
  [66] = 0.492481,
  [67] = 0.507463,
  [68] = 0.529412,
  [69] = 0.550725,
  [70] = 0.571429,
  [71] = 0.591549,
  [72] = 0.611111,
  [73] = 0.630137,
  [74] = 0.648649,
  [75] = 0.666667,
  [76] = 0.684211,
  [77] = 0.701299,
  [78] = 0.717949,
  [79] = 0.734177,
  [80] = 0.750276
};

InfoScreen.GameData = {};

InfoScreen.GameData.CritAnimationList = {
  ["phantom_assassin_attack_crit_anim"] = true,
  ["attack_crit_alt_anim"] = 46,
  ["attack_crit_alt_injured"] = 22,
  ["attack_crit_anim"] = 19,
  ["Attack Critical_anim"] = true,
  ["attack_event"] = true
}

InfoScreen.GameData.CriticalSkills = {
  [0] = 0,
  ["juggernaut_blade_dance"] = {20, 25, 30, 35},
  ["skeleton_king_mortal_strike"] = {9, 11, 13, 15}, --15],//
  ["phantom_assassin_coup_de_grace"] = 15,-- talant 20
  ["lycan_shapeshift"] = 30,
  ["brewmaster_drunken_brawler"] = {10, 15, 20, 25},
  ["chaos_knight_chaos_strike"] = 10
};

--OnSkillsTable = {
  --["ogre_magi_multicast"] = {60, 30, 15},--2x, 3x, 4x
--  ["obsidian_destroyer_essence_aura"] = 40-- talant 55
--};

InfoScreen.GameData.PassiveSkillsChanseAtTakeDamage = {
  [0] = 1,
  --["tiny_craggy_exterior"] = {10, 15, 20, 25},
  --["phantom_assassin_blur"] ={20,30,40,50},
  ["legion_commander_moment_of_courage"] = 25,
  ["axe_counter_helix"] = 20
};

InfoScreen.GameData.PassiveSkillsChanseOnAttack = {
  [0] = 2,
  ["spirit_breaker_greater_bash"] = 17,
  ["slardar_bash"] = {10, 15, 20, 25},
  ["faceless_void_time_lock"] = {10, 15, 20, 25},
  --["phantom_lancer_juxtapose"] ={40,45,50},
  ["troll_warlord_berserkers_rage"] = 10,
  ["sniper_headshot"] = 40
};

InfoScreen.GameData.SkillModifiers = {
	["modifier_item_quelling_blade"]= {24, 7},
	["modifier_item_bfury"] = {0.5, 0.25},
	--["modifier_item_iron_talon"] = {1.4},
	["modifier_bloodseeker_bloodrage"] = {0.25, 0.3, 0.35, 0.4}
};

--modules
InfoScreen.Pseudo = {};
InfoScreen.ManaBar = {};
InfoScreen.EnemyTeamStatus = {};
InfoScreen.ImmunitySphere = {};
InfoScreen.ItemPanel = {};
InfoScreen.EnemyHeroes = {};
InfoScreen.MissingHero = {};

InfoScreen.Pseudo.NoLuckCount = {};
InfoScreen.Pseudo.AttackAnimationCheck = {};
InfoScreen.Pseudo.AttackAnimationCheck.Time = 0;
InfoScreen.Pseudo.AttackAnimationCheck.Skills = {};
InfoScreen.Pseudo.Chanses = {};
InfoScreen.Pseudo.FindedList = {};
InfoScreen.Pseudo.Enabled = false;
InfoScreen.Pseudo.Timer = 0;
InfoScreen.Pseudo.TimerInterval = 0.5;

InfoScreen.EnemyTeamStatus.Timer = 0;
InfoScreen.EnemyTeamStatus.TimerInterval = 0.5;
InfoScreen.EnemyTeamStatus.EnemyData = {};

InfoScreen.ImmunitySphere.Timer = 0;
InfoScreen.ImmunitySphere.TimerInterval = 0.25;
InfoScreen.ImmunitySphere.ParticleName = "particles/items_fx/immunity_sphere_buff.vpcf";
InfoScreen.ImmunitySphere.QOPCD = 0;

InfoScreen.EnemyHeroes.Timer = 0;
InfoScreen.EnemyHeroes.TimerInterval = 0.25;

InfoScreen.ItemPanel.Timer = 0;
InfoScreen.ItemPanel.TimerInterval = 0.5;

InfoScreen.MissingHero.Font = nil;

InfoScreen.Renderer.Font = nil;
InfoScreen.Renderer.FontMid = nil;
InfoScreen.Renderer.FontBig = nil;
InfoScreen.Renderer.ImageEmpty = nil;
InfoScreen.Renderer.ImageBB = nil;
InfoScreen.Renderer.ImageNoBB = nil;
InfoScreen.Renderer.ImageBottleEmpty = nil;
InfoScreen.Renderer.ImageBottleMiddle = nil;
Renderer.ScreenWidth, Renderer.ScreenHeight = Renderer.GetScreenSize();
InfoScreen.Renderer.XBarOffset = 0;
InfoScreen.Renderer.YBarOffset = 0;
InfoScreen.Renderer.YBottomOffset = -17;
InfoScreen.Renderer.BorderSize = 1;
InfoScreen.Renderer.HPBarWidth = 129;--129 at 1080
InfoScreen.Renderer.HPBarHeight = 15;--15 at 1080
InfoScreen.Renderer.TopHeroIconsWidth = 315;--315 at 1080
InfoScreen.Renderer.TopHeroIconsHeight = 24;--24 at 1080
InfoScreen.Renderer.TopHeroIconsSkillSize = 0.25;
InfoScreen.Renderer.TopHeroIconsRespawnHeight = 27;


InfoScreen.Menu.ScriptName = "Info Screen";
InfoScreen.Menu.AllEnabled = Menu.AddOptionBool({InfoScreen.Menu.ScriptName}, "Enabled", false);
InfoScreen.Menu.Debug = Menu.AddOptionBool({InfoScreen.Menu.ScriptName}, "Debug Log", false);

InfoScreen.Menu.Pseudo = {};
InfoScreen.Menu.Pseudo.Path = {InfoScreen.Menu.ScriptName, "Pseudo"};
InfoScreen.Menu.Pseudo.PanelsPath = {InfoScreen.Menu.ScriptName, "Pseudo", "Panels"};
InfoScreen.Menu.Pseudo.Enabled = Menu.AddOptionBool(InfoScreen.Menu.Pseudo.Path, "Enabled", false);
InfoScreen.Menu.Pseudo.OverHero = Menu.AddOptionBool(InfoScreen.Menu.Pseudo.Path, "Show Over Hero", true);
InfoScreen.Menu.Pseudo.Panels = {};

InfoScreen.Menu.ManaBar = Menu.AddOptionBool({InfoScreen.Menu.ScriptName, "Over Hero"}, "Mana Bars", false);
InfoScreen.Menu.HealthText = Menu.AddOptionBool({InfoScreen.Menu.ScriptName, "Over Hero"}, "Health Text", false);
InfoScreen.Menu.EnemyTeamStatus = Menu.AddOptionBool({InfoScreen.Menu.ScriptName, "Enemy Team Status"}, "Status Panel", false);

InfoScreen.Menu.MissingHero = {};
InfoScreen.Menu.MissingHero.Path = {InfoScreen.Menu.ScriptName, "Enemy Team Status", "Missing Hero"};
InfoScreen.Menu.MissingHero.Enabled = Menu.AddOptionBool(InfoScreen.Menu.MissingHero.Path, "Enabled", false);
InfoScreen.Menu.MissingHero.ToggleKey = Menu.AddKeyOption(InfoScreen.Menu.MissingHero.Path,"Toggle Key",Enum.ButtonCode.BUTTON_CODE_NONE);
InfoScreen.Menu.MissingHero.OffsetX = Menu.AddOptionSlider(InfoScreen.Menu.MissingHero.Path,"X Position", 0, Renderer.ScreenWidth, 50);
InfoScreen.Menu.MissingHero.OffsetY = Menu.AddOptionSlider(InfoScreen.Menu.MissingHero.Path,"Y Position", 0, Renderer.ScreenHeight, 50);
InfoScreen.Menu.MissingHero.Opacity = Menu.AddOptionSlider(InfoScreen.Menu.MissingHero.Path,"Opacity", 10, 255, 255);
InfoScreen.Menu.MissingHero.SizeImg = Menu.AddOptionSlider(InfoScreen.Menu.MissingHero.Path,"Size", 8, 64, 30);
InfoScreen.Menu.MissingHero.OnMinimapActivation = Menu.AddOptionBool(InfoScreen.Menu.MissingHero.Path,"Last position on MiniMap", false);
InfoScreen.Menu.MissingHero.MiniMapSizeImg = Menu.AddOptionSlider(InfoScreen.Menu.MissingHero.Path,"Size MiniMap", 500, 1500, 1000);



InfoScreen.Menu.ImmunitySphere = Menu.AddOptionBool({InfoScreen.Menu.ScriptName, "Show Linken Pretect"}, "Enabled", false);
--
--InfoScreen.Menu.BuffsDebuffs = Menu.AddOptionBool({InfoScreen.Menu.ScriptName, "Show Buffs/Debuffs"}, "Enabled", false);
InfoScreen.Menu.ItemPanel = {};
InfoScreen.Menu.ItemPanel.OptionsHero = {InfoScreen.Menu.ScriptName, "Over Hero", "Item Panel"};
InfoScreen.Menu.ItemPanel.OptionsSide = {InfoScreen.Menu.ScriptName, "Item Panel", "Side Bar"};
InfoScreen.Menu.ItemPanel.EnabledSide = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsSide, "Enabled", false);
InfoScreen.Menu.ItemPanel.SideIconSize =  Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsSide, "Icon Size", 12, 64, 32);
InfoScreen.Menu.ItemPanel.Orientation = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsSide, "Vertical orientation", false);
InfoScreen.Menu.ItemPanel.ShowStashSide = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsSide, "Show Stash", true);
InfoScreen.Menu.ItemPanel.OpacitySide = Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsSide, "Opacity", 0, 255, 255);
InfoScreen.Menu.ItemPanel.PositionX = Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsSide, "Position X", 0, Renderer.ScreenWidth, 0);
InfoScreen.Menu.ItemPanel.PositionY = Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsSide, "Position Y", 0, Renderer.ScreenHeight, 0);
InfoScreen.Menu.ItemPanel.MoveKey = Menu.AddKeyOption(InfoScreen.Menu.ItemPanel.OptionsSide, "Panel Move Key", Enum.ButtonCode.BUTTON_CODE_NONE);

InfoScreen.Menu.ItemPanel.HeroPanel = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsHero, "Enabled", false);
InfoScreen.Menu.ItemPanel.OverheroIconSize =  Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsHero, "Icon Size", 12, 64, 32);
InfoScreen.Menu.ItemPanel.ViewMode = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsHero, "Line View Mode", false);
InfoScreen.Menu.ItemPanel.ShowStashHero = Menu.AddOptionBool(InfoScreen.Menu.ItemPanel.OptionsHero, "Show Stash", true);
InfoScreen.Menu.ItemPanel.OpacityHero = Menu.AddOptionSlider(InfoScreen.Menu.ItemPanel.OptionsHero, "Opacity", 0, 255, 255);



Menu.LoadSettings();

function InfoScreen.isEnabled()
	return Menu.IsEnabled(InfoScreen.Menu.AllEnabled);
end;

function InfoScreen.Menu.ItemPanel.LoadSettings()
  InfoScreen.ItemPanel.EnabledSide = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.EnabledSide);
  InfoScreen.ItemPanel.HeroPanel = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.HeroPanel);
  InfoScreen.ItemPanel.SideIconSize =  Menu.GetValue(InfoScreen.Menu.ItemPanel.SideIconSize);
  InfoScreen.ItemPanel.OverheroIconSize = Menu.GetValue(InfoScreen.Menu.ItemPanel.OverheroIconSize);
  InfoScreen.ItemPanel.Orientation = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.Orientation);
  InfoScreen.ItemPanel.ViewMode = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.ViewMode);
  InfoScreen.ItemPanel.ShowStashSide = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.ShowStashSide);
  InfoScreen.ItemPanel.ShowStashHero = Menu.IsEnabled(InfoScreen.Menu.ItemPanel.ShowStashHero);
  InfoScreen.ItemPanel.OpacitySide = Menu.GetValue(InfoScreen.Menu.ItemPanel.OpacitySide);
  InfoScreen.ItemPanel.OpacityHero = Menu.GetValue(InfoScreen.Menu.ItemPanel.OpacityHero);
  InfoScreen.ItemPanel.PositionX = Menu.GetValue(InfoScreen.Menu.ItemPanel.PositionX);
  InfoScreen.ItemPanel.PositionY = Menu.GetValue(InfoScreen.Menu.ItemPanel.PositionY);
end;

function InfoScreen.Menu.MissingHero.LoadSettings()
  InfoScreen.MissingHero.Enabled = Menu.IsEnabled(InfoScreen.Menu.MissingHero.Enabled);
  InfoScreen.MissingHero.PositionX = Menu.GetValue(InfoScreen.Menu.MissingHero.OffsetX);
  InfoScreen.MissingHero.PositionY = Menu.GetValue(InfoScreen.Menu.MissingHero.OffsetY);
  InfoScreen.MissingHero.Opacity = Menu.GetValue(InfoScreen.Menu.MissingHero.Opacity);
  InfoScreen.MissingHero.Size = Menu.GetValue(InfoScreen.Menu.MissingHero.SizeImg);
  InfoScreen.MissingHero.OnMinimapEnbled = Menu.IsEnabled(InfoScreen.Menu.MissingHero.OnMinimapActivation);
  InfoScreen.MissingHero.MiniMapSize = Menu.GetValue(InfoScreen.Menu.MissingHero.MiniMapSizeImg);
end;

--Menu
function InfoScreen.Menu.AddOptionBool(path, name, list)
  --Log.Write("InfoScreen : Add to menu - "..name);
  list[name] = Menu.AddOptionBool(path, name, true);
end;
function InfoScreen.Pseudo.isEnabled()
	return InfoScreen.isEnabled() and Menu.IsEnabled(InfoScreen.Menu.Pseudo.Enabled);
end;

function InfoScreen.isDebug()
	return InfoScreen.isEnabled() and  Menu.IsEnabled(InfoScreen.Menu.Debug);
end;
--Menu

--Utils
function Renderer.DrawFilledShadowedRect (x, y, w, h)
  Renderer.DrawFilledRect(x, y, w, h);
  Renderer.SetDrawColor(0, 0, 0, 188);
  Renderer.DrawOutlineRect(x, y, w, h);
end;

function Renderer.DrawTextAlign(font, x, y, w, h, text, HorizonalAlign, VerticalAlign)
  local textW, textH = Renderer.GetTextSize(font, text);
  local textX, textY = x, y;
  if VerticalAlign and (VerticalAlign ~= -1) then
    if (VerticalAlign == 0) then
      textY = y + floor(h * 0.5 - (textH * 0.5));
    end;
    if (VerticalAlign > 0) then
      textY = y + (h - textH);
    end;
  end;
  if HorizonalAlign and (HorizonalAlign ~= -1) then
    if (HorizonalAlign == 0) then
      textX = x + floor(w * 0.5 - (textW * 0.5));
    end;
    if (HorizonalAlign > 0) then
      textX = x + (w - textW);
    end;
  end;
  Renderer.DrawText(font, textX, textY, text, 1);
end;

function Renderer.IsOnScreen(x, y)
  if (x<0) or (y<0) then return false; end;
  if (x>Renderer.ScreenWidth) or (y>Renderer.ScreenHeight) then return false; end;
  return true;
end;

function Renderer.DrawHPBar(x, y, barWidth, barHeight, barcolor, percent, text, index)
  if percent > 0.98 then
    percent = 1
  end;
  if not index then
    index = 0;
  end;
  Renderer.SetDrawColor(0, 0, 0, 125);
  Renderer.DrawFilledShadowedRect(x ,y - barHeight*index, barWidth + InfoScreen.Renderer.BorderSize, barHeight);
  Renderer.SetDrawColor(0, 0, 0, 255);
  Renderer.DrawOutlineRect(x ,y - barHeight*index, barWidth + InfoScreen.Renderer.BorderSize, barHeight);
  Renderer.SetDrawColor(barcolor[1], barcolor[2], barcolor[3], barcolor[4]);
  Renderer.DrawFilledShadowedRect(x + InfoScreen.Renderer.BorderSize, y + InfoScreen.Renderer.BorderSize - barHeight * index, ceil(barWidth * percent), barHeight - InfoScreen.Renderer.BorderSize * 2);
  if text then
    Renderer.SetDrawColor(222, 222, 222, 255);
    --local textW, textH = Renderer.GetTextSize(InfoScreen.Renderer.Font, text);
    --left align
    Renderer.DrawTextAlign(InfoScreen.Renderer.Font, x + InfoScreen.Renderer.BorderSize * 3, y - barHeight * index, barWidth, barHeight, tostring(floor(percent*100)).."%", -1, 0);
    --right align
    Renderer.DrawTextAlign(InfoScreen.Renderer.Font, x - InfoScreen.Renderer.BorderSize, y - barHeight * index, barWidth, barHeight, text, 1, 0);
  end;
end;
--particles
function InfoScreen.CreateRangeParticle(index, ent, name)
	if (ent == nil) then
		return false;
	end;
	if (InfoScreen.Particles[index] == nil) then
		InfoScreen.Particles[index] = {};
    InfoScreen.Particles[index].ID = Particle.Create(name, Enum.ParticleAttachment.PATTACH_ABSORIGIN_FOLLOW, ent);
    Particle.SetControlPoint(InfoScreen.Particles[index].ID, 0, Vector(1, 0, 0));
    Particle.SetControlPoint(InfoScreen.Particles[index].ID, 6, Vector(1, 0, 0));
		return true;
	end;
	return false;
end;
function InfoScreen.ClearParticle(index)
	if (InfoScreen.Particles[index] ~= nil) and (InfoScreen.Particles[index].ID ~= nil) then
		Particle.Destroy(InfoScreen.Particles[index].ID);
		InfoScreen.Particles[index] = nil;
	end;
end;
--
function InfoScreen.IsLinkensProtected(ent)
  if not ent then
    return false;
  end;
  if NPC.IsLinkensProtected(ent) then 
    return true; 
  end;
  local spell_shield = NPC.GetAbility(ent, "antimage_spell_shield");
  local qop_spell_block = NPC.GetAbility(ent, "special_bonus_spell_block_15");
  if (
      (spell_shield and Ability.IsReady(spell_shield) and (NPC.HasModifier(ent, "modifier_item_ultimate_scepter") or NPC.HasModifier(ent, "modifier_item_ultimate_scepter_consumed")))
      or
      (qop_spell_block and Ability.IsReady(qop_spell_block) and (InfoScreen.ImmunitySphere.QOPCD < GameTime))
    )
    and not NPC.HasModifier(ent,"modifier_silver_edge_debuff") and not NPC.HasModifier(ent,"modifier_viper_nethertoxin") then
      return true;
  end;
  return false;
end;
function InfoScreen.GetAbilities(entity)
  local list = {};
  local J = 0;
  for i=0, 24 do	
		local abil = NPC.GetAbilityByIndex(entity, i);
		if abil and (Ability.GetLevel(abil) >= 1) and not Ability.IsHidden(abil) then
      list[J] = abil;
      J = J + 1;
		end;
  end;
  return list;
end;
function InfoScreen.GetItems(entity)
  local list = {};
  local J = 0;
  for i=0, 9 do	
		local item = NPC.GetItemByIndex(entity, i);
    if item then
      list[J] = item;
      J = J + 1;
		end;
  end;
  return list;
end;

function InfoScreen.WriteHeroInfo(entity)
  local EnemyHero = Global.EnemyHeroes[entity];
  if not EnemyHero then
    Global.EnemyHeroes[entity] = {};
    EnemyHero = Global.EnemyHeroes[entity];
    -- EnemyHero = {};
    EnemyHero.Name = NPC.GetUnitName(entity);
    EnemyHero.IconName = EnemyHero.Name:sub(string.len("npc_dota_hero_") + 1);
    EnemyHero.Image = nil;
    EnemyHero.HBO = 0;--NPC.GetHealthBarOffset(entity);
    EnemyHero.TeamNum = Entity.GetTeamNum(entity);
    EnemyHero.PlayerID = Hero.GetPlayerID(entity);
    EnemyHero.LastSeenTime = 0;
    EnemyHero.MP = 1;
    EnemyHero.MaxMP = 1;
    EnemyHero.HP = 1;
    EnemyHero.MaxHP = 1;
    EnemyHero.IsLinkensProtected = false;
    EnemyHero.Position = nil;
    --EnemyHero.Items = {};
    --EnemyHero.Abilities = {};
  end;
  EnemyHero.IsWaitingToSpawn = NPC.IsWaitingToSpawn(entity);

  EnemyHero.Visible = NPC.IsVisible(entity);
  EnemyHero.Alive = Entity.IsAlive(entity);
  EnemyHero.Dormant = Entity.IsDormant(entity);
  if (not EnemyHero.Alive or EnemyHero.Dormant) and (EnemyHero.LastSeenTime == 0) then
    EnemyHero.LastSeenTime = GameTime;
  elseif EnemyHero.Alive and not EnemyHero.Dormant and (EnemyHero.LastSeenTime ~= 0) then
    EnemyHero.LastSeenTime = 0;
  end;
  EnemyHero.Valid = (EnemyHero.Visible and EnemyHero.Alive and not EnemyHero.Dormant);
  if EnemyHero.Valid then
    --if (EnemyHero.HBO == 0) then
      EnemyHero.HBO =  NPC.GetHealthBarOffset(entity);
      EnemyHero.Position = Entity.GetAbsOrigin(entity);
    --end;
    EnemyHero.MP = ceil(NPC.GetMana(entity));
    EnemyHero.MaxMP = ceil(NPC.GetMaxMana(entity));
    EnemyHero.HP = ceil(Entity.GetHealth(entity));
    EnemyHero.MaxHP = ceil(Entity.GetMaxHealth(entity));
    EnemyHero.IsLinkensProtected = Menu.IsEnabled(InfoScreen.Menu.ImmunitySphere) and InfoScreen.IsLinkensProtected(heroent);
    EnemyHero.Items = InfoScreen.WriteItems(entity);
    EnemyHero.Abilities = InfoScreen.WriteAbilities(entity);
  end;
  --Log.Write(table.tostring(EnemyHero));
  --Global.EnemyHeroes[entity] = EnemyHero;
end;
function InfoScreen.WriteItem(itemID)
  if itemID then
    local item = Global.Items[itemID];
    if not item then
      Global.Items[itemID] = {};
      item = Global.Items[itemID];
      --item = {};
      item.Name = Ability.GetName(itemID);
      if item.Name:find("recipe") then
        item.IconName = "recipe";
      else
        item.IconName = string.sub(item.Name ,string.len("item_") + 1);
      end;
      item.Image = nil;
      item.Cooldown = 0;
      item.CooldownLength = Ability.GetCooldownLength(itemID);
      --item.CastRange = Ability.GetCastRange(itemID);
      --item.ManaCost = Ability.GetManaCost(itemID);
      if Item.IsCombinable(itemID) then
        item.Count = 0;
      else 
        item.Count = -1;
      end;
    end;
    if item.Count ~= -1 then
      item.Count = Item.GetCurrentCharges(itemID);
      if (item.IconName == "bottle") then
        if (item.Count == 0) then
          item.Image  = InfoScreen.Renderer.ImageBottleEmpty;
        elseif (item.Count < 3) then
          item.Image = InfoScreen.Renderer.ImageBottleMiddle;
        end;
      end;
    end;
    item.CooldownLength = Ability.GetCooldownLength(itemID);
    local Cooldown = Ability.GetCooldown(itemID);
    if (item.Cooldown == 0) and (Cooldown > 0) then
      item.Cooldown = ceil(GameTime + Cooldown);
    elseif ((item.Cooldown < GameTime) or (Cooldown == 0)) 
      and (item.Cooldown ~= ceil(GameTime + Cooldown)) 
    then
      item.Cooldown = 0;
    end;    
    --Global.Items[itemID] = item;
  end;
end;
function InfoScreen.WriteAbility(abilityID)
  if abilityID then
    local ability = Global.Abilities[abilityID];
    if not ability then
      Global.Abilities[abilityID] = {};
      ability = Global.Abilities[abilityID];
      --ability = {};
      ability.Name = Ability.GetName(abilityID);
      ability.IconName = ability.Name;
      ability.Image = nil;
      ability.Level = 0;
      ability.Type = Ability.GetType(abilityID);
      ability.Cooldown = 0;
      ability.CooldownLength = 1;
    end;
    local level = Ability.GetLevel(abilityID);
    --some time update
    if (ability.Level ~= Ability.GetLevel(abilityID)) then
      ability.Level = level;
      --ability.CooldownLength = Ability.GetCooldownLength(abilityID);
      --ability.CastRange = Ability.GetCastRange(abilityID);
      --ability.ManaCost = Ability.GetManaCost(abilityID);
    end;
    local Cooldown = Ability.GetCooldown(abilityID);
    if (ability.Cooldown == 0) and (Cooldown > 0) then
      ability.CooldownLength = Ability.GetCooldownLength(abilityID);
      ability.Cooldown = ceil(GameTime + Cooldown);
    elseif ((ability.Cooldown < GameTime) or (Cooldown == 0)) 
      and (ability.Cooldown ~= ceil(GameTime + Cooldown)) 
    then
      ability.Cooldown = 0;
    end;
    --Global.Abilities[abilityID] = ability;
  end;
end;
function InfoScreen.WriteItems(entity)
  local list = {};	
  local temp = {};
  temp.ID = 0;
  temp.Index = -1;
  local j = 1;
  for i = 0, 8 do
    local itemID = NPC.GetItemByIndex(entity, i);
    if itemID and Entity.IsAbility(itemID) then
      InfoScreen.WriteItem(itemID);
      --used[i] = true;
      list[j] = {};
      list[j].ID = itemID;
      list[j].Index = i;
      j = j+1;
    end;
  end;
  return list;--, used
end;
function InfoScreen.WriteAbilities(entity)
  local list = {};
  local temp = {};
  temp.ID = 0;
  temp.Index = -1;	
  local j = 1;
  for i = 0, 24 do
    local abilityID = NPC.GetAbilityByIndex(entity, i);
    if abilityID and Entity.IsAbility(abilityID) and (Ability.GetLevel(abilityID)>0) and not Ability.IsHidden(abilityID) and not Ability.IsAttributes(abilityID) then
      InfoScreen.WriteAbility(abilityID);
      list[j] = {};
      list[j].ID = abilityID;
      list[j].Index = i;
      j = j+1;
    end;
  end;
  return list;
end;

function InfoScreen.LoadHeroImages(entity, Hero)
  if not Hero.Image then
    if not InfoScreen.Images[entity] then
      Log.Write("Load - panorama/images/heroes/npc_dota_hero_"..Hero.IconName.."_png.vtex_c");
      InfoScreen.Images[entity] = Renderer.LoadImage("panorama/images/heroes/npc_dota_hero_"..Hero.IconName.."_png.vtex_c");
      if not InfoScreen.Images[entity] then
        InfoScreen.Images[entity] = InfoScreen.Renderer.ImageEmpty;
      end;
    end;
    Hero.Image = InfoScreen.Images[entity];
  end;
  if not InfoScreen.Renderer.ImageEmpty then
    InfoScreen.Renderer.ImageEmpty = Renderer.LoadImage("panorama/images/spellicons/empty_png.vtex_c");
  end;
  if not InfoScreen.Renderer.ImageBB then
    InfoScreen.Renderer.ImageBB = Renderer.LoadImage("panorama/images/spellicons/buyback_png.vtex_c");
  end;
  if not InfoScreen.Renderer.ImageNoBB then
    InfoScreen.Renderer.ImageNoBB = Renderer.LoadImage("panorama/images/spellicons/modifier_buyback_gold_penalty_png.vtex_c");
  end;
  if not InfoScreen.Renderer.ImageBottleEmpty then
    InfoScreen.Renderer.ImageBottleEmpty = Renderer.LoadImage("panorama/images/items/bottle_empty_png.vtex_c");
  end;
  if not InfoScreen.Renderer.ImageBottleMiddle then
    InfoScreen.Renderer.ImageBottleMiddle = Renderer.LoadImage("panorama/images/items/bottle_medium_png.vtex_c");
  end;
  if Hero.Abilities then
    for j=1, #Hero.Abilities do
      local id = Hero.Abilities[j].ID;
      local ability = Global.Abilities[id];
      if ability and (ability.Type == Enum.AbilityTypes.ABILITY_TYPE_ULTIMATE) 
      then
        if not ability.Image then
          local temp = InfoScreen.Images[ability.IconName];
          if not temp then
            temp = Renderer.LoadImage("panorama/images/spellicons/"..ability.IconName.."_png.vtex_c");
            if not temp then
              Log.Write("Can`t load - panorama/images/spellicons/"..ability.IconName.."_png.vtex_c");
              temp = InfoScreen.Renderer.ImageEmpty;
            else
              Log.Write("Loaded - panorama/images/spellicons/"..ability.IconName.."_png.vtex_c");
            end;
            InfoScreen.Images[ability.IconName] = temp;
          end;
          ability.Image = temp;
        end;
      end;
    end;
  end;
  if Hero.Items then
    for j=1, #Hero.Items do
      local id = Hero.Items[j].ID;
      local Item = Global.Items[id];
      if Item then
        if not Item.Image then
          local temp = InfoScreen.Images[Item.IconName];
          if not temp then
            temp = Renderer.LoadImage("panorama/images/items/"..Item.IconName.."_png.vtex_c");
            if not temp then
              Log.Write("Can`t load - panorama/images/items/"..Item.IconName.."_png.vtex_c");
              temp = InfoScreen.Renderer.ImageEmpty;
            else
              Log.Write("Loaded - panorama/images/items/"..Item.IconName.."_png.vtex_c");
            end;
            InfoScreen.Images[Item.IconName] = temp;
          end;
          Item.Image = temp;
        end;
      end;
    end;
  end;
end;
--Dota 2 Clases Entity based OOP
local D2Unit = {};
function D2Unit:new (entity)
  local object = nil;
  if (entity and (entity ~= 0)) then
    object = {};
    object.UpdateTime = 0.25;
    function object:Init()
      object.LastUpdateTime = 0;
      object.Entity = entity;
      --static properties
      --Entity.(.+)\(ent object.$1 = Entity.$1(entity
      object.ClassName = Entity.GetClassName(entity);
      object.IsNPC = Entity.IsNPC(entity);
      object.IsHero = Entity.IsHero(entity);
      object.IsPlayer = Entity.IsPlayer(entity);
      object.IsAbility = Entity.IsAbility(entity);
      --object.GetOwner = Entity.GetOwner(entity);
      --object.RecursiveGetOwner = Entity.RecursiveGetOwner(entity);
      --NPC.(.+)\(npc object.$1 = Entity.$1(entity
      object.Name = NPC.GetUnitName(entity);
      object.IsRanged = NPC.IsRanged(entity);
      object.HealthBarOffset = NPC.GetHealthBarOffset(entity);
      object.TeamNum = Entity.GetTeamNum(entity);
      object.AttackPoint = HeroInfo[object.Name].AttackPoint;
      object.Abilities = {};
      object.Items = {};
      object.Modifiers = {};

      object.Level = 1;
    end;
    object:Init();
    --methods
    function object:Update(Ent)
      if ((GameTime - object.LastUpdateTime) > object.UpdateTime) then
        if Ent and (entity~=ent) then
          --Log.Write(entity.."="..Ent);
          entity = Ent;
          object:Init();
        end;
        object.LastUpdateTime = GameTime;
        --
        object.Visible = NPC.IsVisible(entity);
        object.Alive = Entity.IsAlive(entity);
        object.Dormant = Entity.IsDormant(entity);
        object.Valid = (object.Visible and object.Alive and not object.Dormant);
        if object.Valid then
          object.HP = Entity.GetHealth(entity);
          object.MaxHP = Entity.GetMaxHealth(entity);
          --
          object.MP = NPC.GetMana(entity);
          object.MaxMP = NPC.GetMaxMana(entity);
          object.Damage = NPC.GetTrueDamage(entity);
          object.MaximumDamage = NPC.GetTrueMaximumDamage(entity);
          object.AttackRange = NPC.GetAttackRange(entity);
          object.TrueAttackPoint = (object.AttackPoint / (1 + (NPC.GetIncreasedAttackSpeed(entity) / 100))) + (object.AttackPoint * 0.17);
          object.MoveSpeed = NPC.GetMoveSpeed(entity);
          object.Level = NPC.GetCurrentLevel(entity);
          --lists
          object.Abilities = InfoScreen.GetAbilities(entity);
          object.Items = InfoScreen.GetItems(entity);
          object.Modifiers = NPC.GetModifiers(entity);
        end;
        return true;
      end;
      return false;
    end;
    object:Update();
    function object:ForceUpdate(ent)
      object.LastUpdateTime = 0;
      return object:Update(ent);
    end;
    
    function object:GetItem(Name)
      return NPC.GetItem(self.Entity, Name);
    end;
    function object:GetAbility(Name)
      return NPC.GetAbility(self.Entity, Name);
    end;
    function object:GetModifier(Name)
      return NPC.GetModifier(self.Entity, Name);
    end;

    function object:HasState(Name)
      return NPC.HasState(self.Entity, Name);
    end;
    function object:HasModifier(Name)
      return NPC.HasModifier(self.Entity, Name);
    end;

    function object:GetAbsOrigin()
      object.AbsOrigin = Entity.GetAbsOrigin(self.Entity);
      return object.AbsOrigin;
    end;
    function object:IsAlive()
      --object.IsAlive = Entity.IsAlive(self.Entity);
      return object.IsAlive;
    end;
    function object:GetLevel()
      --object.Level = NPC.GetCurrentLevel(self.Entity);
      return object.Level;
    end;
    function object:GetMana()
      --object.MP = NPC.GetMana(self.Entity);
      return object.MP;
    end;

    setmetatable(object, self);
    self.__index = self;
  end;
  return object;
end;

--Dota 2 Clases Entity based OOP

function InfoScreen.IsCastNow(entity)
	if not entity then return false, nil end;	
	for i=0, 24 do	
		local abil = NPC.GetAbilityByIndex(entity, i);
		if abil and (Ability.GetLevel(abil) >= 1) and not Ability.IsHidden(abil) and not Ability.IsPassive(abil) and (Ability.IsInAbilityPhase(abil) or Ability.IsChanneling(abil)) then
			return true, abil;
		end;
  end;
  if NPC.HasModifier(entity, "modifier_teleporting") then return true, nil end;
	return false, nil;
end;

function InfoScreen.GetTarget(creep, team)
	if not creep then return end;
	if not Entity.IsAlive(creep) then return end;
	
	local creepRotation = Entity.GetRotation(creep):GetForward():Normalized();
	
  local targets = Entity.GetUnitsInRadius(creep, 280, team);

  if not targets then return end;
	if next(targets) == nil then return end;

	if #targets <= 2 then
		if (targets[1] ~= creep) then
			return targets[1];
		end;
	else
		local adjustedHullSize = 20;
		for _, v in pairs(targets) do
			if v and (v ~= creep) and Entity.IsAlive(v) then
				local vpos = Entity.GetAbsOrigin(v);
				local vposZ = vpos:GetZ();
				local pos = Entity.GetAbsOrigin(creep);
				for i = 1, 9 do
					local searchPos = pos + creepRotation:Scaled(25*(9-i));
					searchPos:SetZ(vposZ);
					if NPC.IsPositionInRange(v, searchPos, adjustedHullSize, 0) then
						return v;
					end;
				end;
			end;
		end;
	end;
	return;
end;

function Ability.HasBehavior(ability, behavior)
  return Ability.GetBehavior(ability) & behavior ~= 0
end;
--Utils

function InfoScreen.CheckInTable(list, SkillToCheck)
  if not list or not SkillToCheck then
    return false;
  end;
  for name, chanses in pairs(list) do
    local AbilityName = Ability.GetName(SkillToCheck);
    if (name == AbilityName) then
      local chanse = 0;
      local level = Ability.GetLevel(SkillToCheck);
      local NoLuckCount = 1;
      if InfoScreen.Pseudo.NoLuckCount[name] then
        NoLuckCount = InfoScreen.Pseudo.NoLuckCount[name];
      else
        InfoScreen.Pseudo.NoLuckCount[name] = 1;
      end;
      if (type(chanses) == "table") then
        InfoScreen.Pseudo.FindedList[name] = {name:gsub(User.Name:gsub('npc_dota_hero_', '', 1)..'_', '', 1):gsub("_", " "), NoLuckCount * (InfoScreen.PseudoData.ChanseTable[chanses[level]] + 0.02), list[0], SkillToCheck};
      else
        InfoScreen.Pseudo.FindedList[name] = {name:gsub(User.Name:gsub('npc_dota_hero_', '', 1)..'_', '', 1):gsub("_", " "), NoLuckCount * (InfoScreen.PseudoData.ChanseTable[chanses] + 0.02), list[0], SkillToCheck};
      end;
      return true;
    end;
  end;
  return false;
end;

function InfoScreen.Pseudo.OnParticleCreate(particle)
  if InfoScreen.Pseudo.isEnabled() and particle and User then
    --hero_levelup OnLevelUp
    for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
      if (particle.name:gsub("_", "")==name:gsub("_", "")) and (chanselist[3]==InfoScreen.GameData.PassiveSkillsChanseAtTakeDamage[0]) then
        InfoScreen.Pseudo.NoLuckCount[name] = 1;
      end;
    end;
    --double check damage
    if (InfoScreen.Pseudo.AttackAnimationCheck.Time ~= 0) and (particle.name == "damage_flash") then
      if ((GameTime-InfoScreen.Pseudo.AttackAnimationCheck.Time) > -0.15) then
        for k, name in pairs(InfoScreen.Pseudo.AttackAnimationCheck.Skills) do
          if InfoScreen.Pseudo.NoLuckCount[name] then
            InfoScreen.Pseudo.NoLuckCount[name] = InfoScreen.Pseudo.NoLuckCount[name] + 1;
            InfoScreen.Pseudo.AttackAnimationCheck.Time = 0;
          end;
        end;
      else
        if InfoScreen.isDebug() then
          Log.Write("Animation not end "..(GameTime-InfoScreen.Pseudo.AttackAnimationCheck.Time));
        end;
      end;
    end;
  end;
end;
function InfoScreen.Pseudo.OnUnitAnimation(animation)
  if InfoScreen.Pseudo.isEnabled() and InfoScreen.Pseudo.Enabled and animation and User and (animation.unit==User.Entity) then
    local ent = InfoScreen.GetTarget(User.Entity, Enum.TeamType.TEAM_ENEMY);
    InfoScreen.Pseudo.AttackAnimationCheck.Time = GameTime + User.TrueAttackPoint;-- animation.playbackRate;
    --Log.Write(animation.sequenceName.."="..animation.sequence.." "..animation.sequenceName:lower():find("attack"));
    --Log.Write(animation.playbackRate.." ".." "..animation.castpoint);
    InfoScreen.Pseudo.AttackAnimationCheck.Skills = {};
    if ent then
      if not Entity.IsSameTeam(ent, User.Entity) then
        if (not InfoScreen.GameData.CritAnimationList[animation.sequenceName]) and (animation.sequenceName:lower():find("attack")) then
          for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
            if (not Ability.HasBehavior(chanselist[4], Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_TOGGLE) or Ability.GetToggleState(chanselist[4])) and ((chanselist[3]==InfoScreen.GameData.CriticalSkills[0]) or (chanselist[3]==InfoScreen.GameData.PassiveSkillsChanseOnAttack[0])) then
              InfoScreen.Pseudo.AttackAnimationCheck.Skills[#InfoScreen.Pseudo.AttackAnimationCheck.Skills+1] = name;
              --Log.Write("start anim to "..name);
              --InfoScreen.Pseudo.NoLuckCount[name] = InfoScreen.Pseudo.NoLuckCount[name] + 1;
            end;
          end;
        else
          for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
            if (chanselist[3]==InfoScreen.GameData.CriticalSkills[0]) then
              InfoScreen.Pseudo.NoLuckCount[name] = 1;
            end;
          end;
        end;
      end;
    else
      --Log.Write("Cant find enemy");
    end;
	end;
end;
function InfoScreen.Pseudo.OnUnitAnimationEnd(animation)
  if InfoScreen.Pseudo.isEnabled() and animation and User and (animation.unit==User.Entity) then
    if (InfoScreen.Pseudo.AttackAnimationCheck.Time ~= 0) then
      if ((GameTime-InfoScreen.Pseudo.AttackAnimationCheck.Time) > -0.125) then
        for k, name in pairs(InfoScreen.Pseudo.AttackAnimationCheck.Skills) do
          if InfoScreen.Pseudo.NoLuckCount[name] then
            InfoScreen.Pseudo.NoLuckCount[name] = InfoScreen.Pseudo.NoLuckCount[name] + 1;
          end;
        end;
      else
        if InfoScreen.isDebug() then
          Log.Write("Animation not end "..(GameTime-InfoScreen.Pseudo.AttackAnimationCheck.Time));
        end;
      end;
      InfoScreen.Pseudo.AttackAnimationCheck.Time = 0;
    end;
  end;
end;
function InfoScreen.Pseudo.OnModifierCreate(entity, mod)
  if InfoScreen.Pseudo.isEnabled() and User and mod then
    local ModifierName = Modifier.GetName(mod);
    local ModifierAbility = Modifier.GetAbility(mod);
    if entity and (entity~=0) and NPC.IsEntityInRange(User.Entity, entity, 250) then
      for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
        if (ModifierAbility==chanselist[4]) or ModifierName:lower():gsub("_", ""):find(name:lower():gsub("_", ""))--(v[3]==InfoScreen.GameData.CriticalSkills[0]) 
        then
          if InfoScreen.isDebug() then
            Log.Write(ModifierName.."="..name.." "..ModifierAbility.."="..chanselist[4]); 
          end;
          InfoScreen.Pseudo.NoLuckCount[name] = 1;
        end;
      end;
    end;
	end;
end;

function InfoScreen.ImmunitySphere.OnParticleCreate(particle)
  if (particle.name=="immunity_sphere") then
    InfoScreen.ClearParticle(particle.entity);
    if particle.entity and NPC.GetUnitName(particle.entity)=="npc_dota_hero_queenofpain" then
      InfoScreen.ImmunitySphere.QOPCD = GameTime + 15;
    end;
  end;
end;
function InfoScreen.OnParticleCreate(particle)
  if InfoScreen.isEnabled() then
    if InfoScreen.isDebug() then
      Log.Write(particle.index.." "..particle.name.." "..particle.fullName);
    end;
    InfoScreen.Pseudo.OnParticleCreate(particle);
    InfoScreen.ImmunitySphere.OnParticleCreate(particle);
  end;
end;

function InfoScreen.OnUnitAnimation(animation)
  if InfoScreen.isEnabled() then
    InfoScreen.Pseudo.OnUnitAnimation(animation);
  end;
end;
function InfoScreen.OnUnitAnimationEnd(animation)
  if InfoScreen.isEnabled() then
    InfoScreen.Pseudo.OnUnitAnimationEnd(animation);
  end;
end;
function InfoScreen.OnModifierCreate(entity, mod)
  if InfoScreen.isEnabled() then
    InfoScreen.Pseudo.OnModifierCreate(entity, mod)
  end;
end;
--function InfoScreen.OnPreUpdate()
--  return;
--end;
function InfoScreen.Renderer.CalcPanelSize()
  if not User then
    return
  end;
  InfoScreen.EnemyTeamStatus.uix = floor(Renderer.ScreenWidth / 2) - floor(Renderer.ScreenHeight / 2.59);--417 at 1080
  InfoScreen.EnemyTeamStatus.TeamOffcet = 1;
  if (Entity.GetTeamNum(User.Entity)==2) then
    InfoScreen.EnemyTeamStatus.TeamOffcet = 5;
    InfoScreen.EnemyTeamStatus.uix = floor(Renderer.ScreenWidth / 2) + floor(Renderer.ScreenHeight / 10.5);--102 at 1080
  end;
  InfoScreen.EnemyTeamStatus.uiy = floor(Renderer.ScreenHeight / 27);--40 at 1080
  InfoScreen.Renderer.TopHeroIconsWidth = floor(Renderer.ScreenHeight / 3.43);--315 at 1080
  InfoScreen.Renderer.TopHeroIconsHeight = math.max(floor(Renderer.ScreenHeight / 36), 22);--24 at 1080
  InfoScreen.EnemyTeamStatus.CellWidth = floor(InfoScreen.Renderer.TopHeroIconsWidth * 0.2);
  InfoScreen.EnemyTeamStatus.CellHeight = ceil(InfoScreen.Renderer.TopHeroIconsHeight * 0.35);
  InfoScreen.Renderer.TopHeroIconsRespawnHeight = floor(InfoScreen.Renderer.TopHeroIconsHeight * 1.2);
  InfoScreen.Renderer.XBarOffset = -floor(Renderer.ScreenHeight / 20.2);
  InfoScreen.Renderer.YBarOffset = -floor(Renderer.ScreenHeight / 22);
  InfoScreen.Renderer.HPBarWidth = floor(Renderer.ScreenHeight / 10.5); 
  InfoScreen.Renderer.YTopUserBarOffset = -floor(Renderer.ScreenHeight / 20);
  InfoScreen.Renderer.XUserBarOffset = -floor(Renderer.ScreenHeight / 18.8);
  InfoScreen.Renderer.YBottomOffset = -17;-- -17;at 1080
  InfoScreen.Renderer.BorderSize = 1;
  
  InfoScreen.Renderer.HPBarHeight = floor(Renderer.ScreenHeight / 72);
  InfoScreen.Renderer.HPUserBarWidth = floor(Renderer.ScreenHeight / 8.5);--129 at 1080

  InfoScreen.Renderer.uiCenterX = floor(Renderer.ScreenWidth / 2);
  InfoScreen.Renderer.uiCenterY = floor(Renderer.ScreenHeight / 2);
end;

function InfoScreen.Pseudo.OnUpdate()
  if InfoScreen.Pseudo.isEnabled() and Engine.IsInGame() and User then
    if (InfoScreen.Pseudo.Timer <= GameTime) then
      InfoScreen.Pseudo.Timer = GameTime + InfoScreen.Pseudo.TimerInterval;
      --
      InfoScreen.Pseudo.Enabled = false;
      for _, v in ipairs(User.Abilities) do
        InfoScreen.Pseudo.Enabled = InfoScreen.Pseudo.Enabled or InfoScreen.CheckInTable(InfoScreen.GameData.CriticalSkills, v);
        InfoScreen.Pseudo.Enabled = InfoScreen.Pseudo.Enabled or InfoScreen.CheckInTable(InfoScreen.GameData.PassiveSkillsChanse, v);
        InfoScreen.Pseudo.Enabled = InfoScreen.Pseudo.Enabled or InfoScreen.CheckInTable(InfoScreen.GameData.PassiveSkillsChanseAtTakeDamage, v);
        InfoScreen.Pseudo.Enabled = InfoScreen.Pseudo.Enabled or InfoScreen.CheckInTable(InfoScreen.GameData.PassiveSkillsChanseOnAttack, v);
      end;
      if (InfoScreen.Pseudo.Enabled) then
        for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
          if not InfoScreen.Menu.Pseudo.Panels[chanselist[1]] then
            InfoScreen.Menu.AddOptionBool(InfoScreen.Menu.Pseudo.PanelsPath, chanselist[1], InfoScreen.Menu.Pseudo.Panels);
          end;
          if ((chanselist[3] == InfoScreen.GameData.PassiveSkillsChanseOnAttack[0]) or (chanselist[3] == InfoScreen.GameData.PassiveSkillsChanseAtTakeDamage[0])) and 
            (Ability.IsInAbilityPhase(chanselist[4]) or (Ability.GetCooldown(chanselist[4]) ~= 0) or ((Ability.SecondsSinceLastUse(chanselist[4]) ~= -1) and (Ability.SecondsSinceLastUse(chanselist[4]) <= 0.5)) or not User.Alive) then
            InfoScreen.Pseudo.NoLuckCount[name] = 1;
            if InfoScreen.isDebug() then
              Log.Write("AP="..tostring(Ability.IsInAbilityPhase(chanselist[4])).." CD="..Ability.GetCooldown(chanselist[4]).." SSLU="..Ability.SecondsSinceLastUse(chanselist[4]).." UA="..tostring(User.Alive));
            end;
          end;
          if (chanselist[3] == InfoScreen.GameData.PassiveSkillsChanseAtTakeDamage[0]) then
            if InfoScreen.Pseudo.OldHP and (User.HP < InfoScreen.Pseudo.OldHP) then -- take damage???
              InfoScreen.Pseudo.OldHP = User.HP;--костыль
              InfoScreen.Pseudo.NoLuckCount[name] = InfoScreen.Pseudo.NoLuckCount[name] + 1;
            end;
          end;
        end;
      end;
    end;
  end;
end;
function InfoScreen.EnemyTeamStatus.OnUpdate(entity, EnemyHero)
  if Menu.IsEnabled(InfoScreen.Menu.EnemyTeamStatus) and Engine.IsInGame() and User
  then
    local k = EnemyHero.PlayerID;
    if EnemyHero then
      local temp = InfoScreen.EnemyTeamStatus.EnemyData[k];
      if not temp then
        InfoScreen.EnemyTeamStatus.EnemyData[k] = {};
        temp = InfoScreen.EnemyTeamStatus.EnemyData[k];
        temp.Entity = entity;
        temp.RespawnTime = 0;
        temp.BuyBackTime = 0;
        temp.Ultimate = {};
        temp.Ultimate.Ability = nil;
        temp.Ultimate.Cooldown = 0;
        temp.Ultimate.CooldownLength = 1;
        temp.Ultimate.Icon = nil;
      end;
      --temp.MP = EnemyHero.MP;
      --temp.MaxMP = EnemyHero.MaxMP;
      --temp.HP = EnemyHero.HP;
      --temp.MaxHP = EnemyHero.MaxHP;
      --Ultimate Cooldown
      if EnemyHero.Abilities then--and (not temp.Ultimate.Ability or not (temp.Ultimate.Icon) or (not temp.Ultimate.CooldownLength)) then
        for i=1, #EnemyHero.Abilities do
          local abil = EnemyHero.Abilities[i].ID;
          if Entity.IsAbility(abil) and Ability.IsUltimate(abil) then
            temp.Ultimate.Ability = abil;
            temp.Ultimate.Icon = Global.Abilities[abil].Image;
            temp.Ultimate.Cooldown = Global.Abilities[abil].Cooldown;
            temp.Ultimate.CooldownLength = Global.Abilities[abil].CooldownLength;
          end;
        end;
      --[[elseif temp.Ultimate.Ability then
        local Cooldown = Ability.GetCooldown(temp.Ultimate.Ability);
        if (temp.Ultimate.Cooldown == 0) and (Cooldown > 0) then
          temp.Ultimate.Cooldown = ceil(GameTime + Cooldown);
        elseif ((temp.Ultimate.Cooldown < GameTime) or (Cooldown == 0)) 
          and (temp.Ultimate.Cooldown ~= ceil(GameTime + Cooldown)) 
        then
          temp.Ultimate.Cooldown = 0;
        end;]]
      end;
      --BuyBacks and Respawn Cooldown
      local RespawnTime = Hero.GetRespawnTime(entity);
      if (temp.RespawnTime == 0) and (RespawnTime > GameTime) then
        temp.RespawnTime = ceil(RespawnTime);
      elseif (temp.RespawnTime < GameTime) then
        temp.RespawnTime = 0;
      elseif EnemyHero.Alive and (temp.RespawnTime - GameTime > 2) and (temp.BuyBackTime == 0) then
        temp.BuyBackTime = GameTime + 480;
      end;
      if (temp.BuyBackTime ~= 0) and (temp.BuyBackTime < GameTime) then
        temp.BuyBackTime = 0;
      end;
    end;
  end;
end;

function InfoScreen.ImmunitySphere.OnUpdate(entity, EnemyHero)
  if Menu.IsEnabled(InfoScreen.Menu.ImmunitySphere) and Engine.IsInGame() and User
  then
    if not InfoScreen.IsLinkensProtected(entity) and InfoScreen.Particles[entity] then
      InfoScreen.ClearParticle(entity);
    elseif InfoScreen.IsLinkensProtected(entity) and not InfoScreen.Particles[entity] then
      InfoScreen.CreateRangeParticle(entity, entity, InfoScreen.ImmunitySphere.ParticleName);
    end;
  end;
end;

function InfoScreen.EnemyHeroes.OnUpdate()
  if Engine.IsInGame() and User and (InfoScreen.EnemyHeroes.Timer <= GameTime) 
  then
    InfoScreen.EnemyHeroes.Timer = GameTime + InfoScreen.EnemyHeroes.TimerInterval;
    local heroes = Heroes.GetAll();
    for i=1, #heroes do
      local heroent = heroes[i];
      if not Entity.IsSameTeam(User.Entity, heroent) and not NPC.IsIllusion(heroent) then--and not Entity.IsDormant(heroent)
        InfoScreen.WriteHeroInfo(heroent);
      end;
    end;
  end;
end;

function InfoScreen.ItemPanel.DrawHeroSideBar(entity, Hero, index)
  if InfoScreen.Images[entity] then
    --draw hero image
    Renderer.SetDrawColor(255, 255, 255, InfoScreen.ItemPanel.OpacitySide);
    local x, y = InfoScreen.ItemPanel.PositionX, InfoScreen.ItemPanel.PositionY;
    local IconSize = InfoScreen.ItemPanel.SideIconSize;
    local IconSizeX = ceil(IconSize * 1.375);
    if InfoScreen.ItemPanel.Orientation then
      x = x + (IconSizeX * index);
    else
      y = y + IconSize * index;
    end;
    Renderer.DrawImage(InfoScreen.Images[entity], x, y, IconSizeX, IconSize)
    --x = x;
    --draw items
    local Drawed = {false, false, false, false, false, false, false, false, false};
    if Hero.Items then
      for j=1, #Hero.Items do
        if (j <= 6) or InfoScreen.ItemPanel.ShowStashSide then 
          local ItemId = Hero.Items[j].ID;
          local ItemIndex = Hero.Items[j].Index + 1;
          local Item = Global.Items[ItemId];
          if (j <= 6) then
            Renderer.SetDrawColor(255, 255, 255, InfoScreen.ItemPanel.OpacitySide);
          else
            Renderer.SetDrawColor(140, 140, 140, InfoScreen.ItemPanel.OpacitySide);
          end;
          if Item and Item.Image then
            --Log.Write("Draw "..ItemIndex);
            Drawed[ItemIndex] = true;
            local ix, iy = 0, 0;
            if not InfoScreen.ItemPanel.Orientation then
              ix, iy = x + IconSizeX * ItemIndex, y;
            else
              ix, iy = x, y + IconSize * ItemIndex;
            end;
            Renderer.DrawImage(Item.Image, ix, iy, IconSizeX, IconSize);
            if (Item.Count > 0) then 
              Renderer.DrawTextAlign(InfoScreen.Renderer.Font, ix, iy, IconSizeX, IconSize, Item.Count, 1, 1);
            end;
            if ((Item.Cooldown ~= 0) and (Item.Cooldown > GameTime)) then
              Renderer.SetDrawColor(0, 0, 0, 125);
              Renderer.DrawFilledRect(ix, iy, IconSizeX, IconSize);
              Renderer.SetDrawColor(255, 255, 255, 255);
              Renderer.DrawTextAlign(InfoScreen.Renderer.FontBig, ix, iy, IconSizeX, IconSize, ceil(Item.Cooldown - GameTime), 0, 0);
            end;
          end;
        end;
      end;
    end;
    --draw empty panel
    for j=1, 9 do
      --if not Drawed[j] then Log.Write("not draw "..j); end;
      if not Drawed[j] and (InfoScreen.ItemPanel.ShowStashSide or (j <= 6)) then
        if (j <= 6) then
          Renderer.SetDrawColor(255, 255, 255, InfoScreen.ItemPanel.OpacitySide);
        else
          Renderer.SetDrawColor(140, 140, 140, InfoScreen.ItemPanel.OpacitySide);
        end;
        if InfoScreen.Renderer.ImageEmpty then
					if not InfoScreen.ItemPanel.Orientation then
              ix, iy = x + IconSizeX * j, y;
            else
              ix, iy = x, y + IconSize * j;
            end;
						
          if not InfoScreen.ItemPanel.Orientation then
            Renderer.DrawImage(InfoScreen.Renderer.ImageEmpty, ix, iy, IconSizeX, IconSize);
          else
            Renderer.DrawImage(InfoScreen.Renderer.ImageEmpty, ix, iy, IconSizeX, IconSize);
          end;
        end;
      end;
    end;
  end;
end;

function InfoScreen.ItemPanel.DrawOverHeroBar(entity, Hero)
  --calculation
  local origin = Entity.GetAbsOrigin(entity); 
  origin:SetZ(origin:GetZ() + Hero.HBO);
  local hx, hy = Renderer.WorldToScreen(origin);
  if Renderer.IsOnScreen(hx, hy) then
    local IconSize = InfoScreen.ItemPanel.OverheroIconSize;
    local IconSizeX = ceil(IconSize * 1.375);
    if InfoScreen.ItemPanel.ViewMode then
      hx = hx + InfoScreen.Renderer.XBarOffset;
      if InfoScreen.ItemPanel.ShowStashHero then
        hx = hx + ceil(InfoScreen.Renderer.HPBarWidth / 2 - IconSize * 5); 
      else
        hx = hx + ceil(InfoScreen.Renderer.HPBarWidth / 2 - IconSize * 4); 
      end;
      hy = hy + InfoScreen.Renderer.YBarOffset + ceil(InfoScreen.Renderer.HPBarHeight * 0.4) - IconSize * 2;
    else
      hx = hx + InfoScreen.Renderer.XBarOffset + ceil(InfoScreen.Renderer.HPBarWidth / 2 - ceil(IconSize * 2)); 
      hy = hy + InfoScreen.Renderer.YBarOffset;
      if InfoScreen.ItemPanel.ShowStashHero then
        hy = hy + ceil(InfoScreen.Renderer.HPBarHeight * 0.4) - IconSize * 3;
      else
        hy = hy + ceil(InfoScreen.Renderer.HPBarHeight * 0.4) - IconSize * 2;
      end;
    end;
    local Drawed = {false, false, false, false, false, false, false, false, false};
      --draw items
    if Hero.Items then
      for j=1, #Hero.Items do
        local ItemIndex = Hero.Items[j].Index + 1;
        if (ItemIndex <= 6) or InfoScreen.ItemPanel.ShowStashHero then
          local ItemId = Hero.Items[j].ID;
          local Item = Global.Items[ItemId];
          if (ItemIndex <= 6) then
            Renderer.SetDrawColor(255, 255, 255, InfoScreen.ItemPanel.OpacityHero);
          else
            Renderer.SetDrawColor(140, 140, 140, InfoScreen.ItemPanel.OpacityHero);
          end;
          if Item and Item.Image then
            Drawed[ItemIndex] = true;
            local x, y = 0, 0;
            if InfoScreen.ItemPanel.ViewMode then
              x, y = hx + IconSizeX * ItemIndex, hy + IconSize;
            else
              x, y = hx + IconSizeX * fmod((ItemIndex-1), 3), hy + IconSize * floor((ItemIndex-1) / 3);
            end;
            Renderer.DrawImage(Item.Image, x, y, IconSizeX, IconSize);
            if Item.Count > 0 then 
              Renderer.DrawTextAlign(InfoScreen.Renderer.Font, x, y, IconSizeX, IconSize, Item.Count, 1, 1);
            end;
            if ((Item.Cooldown ~= 0) and (Item.Cooldown > GameTime))then
              Renderer.SetDrawColor(0, 0, 0, 125);
              Renderer.DrawFilledRect(x, y, IconSizeX, IconSize);
              Renderer.SetDrawColor(255, 255, 255, 255);
              Renderer.DrawTextAlign(InfoScreen.Renderer.FontMid, x, y, IconSizeX, IconSize, ceil(Item.Cooldown - GameTime), 0, 0);
            end;
          end;
        end;
      end;
    end;
    --draw empty panel
    for j=1, 9 do
      if not Drawed[j] and (InfoScreen.ItemPanel.ShowStashHero or (j <= 6)) then
        --if not Drawed[j] then Log.Write("not Drawed "..j); end;
        if (j <= 6) then
          Renderer.SetDrawColor(255, 255, 255, InfoScreen.ItemPanel.OpacityHero);
        else
          Renderer.SetDrawColor(140, 140, 140, InfoScreen.ItemPanel.OpacityHero);
        end;
        if InfoScreen.Renderer.ImageEmpty then
          if InfoScreen.ItemPanel.ViewMode then
            Renderer.DrawImage(InfoScreen.Renderer.ImageEmpty, hx + IconSizeX * j, hy + IconSize, IconSizeX, IconSize);
          else
            Renderer.DrawImage(InfoScreen.Renderer.ImageEmpty, hx + IconSizeX * fmod((j-1), 3), hy + IconSize * floor((j-1) / 3), IconSizeX, IconSize);
          end;
        end;
      end;
    end;
  end;
end;

function InfoScreen.MissingHero.DrawHeroSideBar(entity, EnemyHero, index)
  if (InfoScreen.Images[entity] and InfoScreen.MissingHero.Font) then
    --draw hero image
    Renderer.SetDrawColor(255, 255, 255, InfoScreen.MissingHero.Opacity);
    local x, y = InfoScreen.MissingHero.PositionX, InfoScreen.MissingHero.PositionY;
    local IconSize = InfoScreen.MissingHero.Size;
    local IconSizeX = ceil(InfoScreen.MissingHero.Size * 1.375);
    --local XHeroOffset = ceil(IconSize * 0.375);
    --if InfoScreen.ItemPanel.Orientation then
    --  x = x + (IconSizeX * index);
    --else
      y = y + IconSize * index;
    --end;
    Renderer.DrawImage(InfoScreen.Images[entity], x, y, IconSizeX, IconSize);
    --Draw Background
    x = x + (IconSizeX);
    Renderer.SetDrawColor(0, 0, 0, InfoScreen.MissingHero.Opacity);
    Renderer.DrawFilledRect(x,y,IconSizeX * 4,IconSize);
    Renderer.SetDrawColor(255, 255, 255, InfoScreen.MissingHero.Opacity);
    
    --Log.Write(EnemyHero.Name + " " + EnemyHero.LastSeenTime );

    if (EnemyHero.LastSeenTime ~= 0) then  
      Renderer.DrawTextAlign(InfoScreen.MissingHero.Font, x, y,IconSizeX * 4, IconSize, dispTime(GameTime-EnemyHero.LastSeenTime), 0, 0);
    else
      Renderer.DrawTextAlign(InfoScreen.MissingHero.Font, x, y,IconSizeX * 4, IconSize, "Visible", 0, 0);
    end;
  end;
end;

function InfoScreen.MissingHero.DrawHeroMinimap(entity, EnemyHero)
  if (EnemyHero.Position and (EnemyHero.LastSeenTime ~= 0)) then
    MiniMap.DrawHeroIcon(EnemyHero.Name, EnemyHero.Position, 255, 255, 255, 255, InfoScreen.MissingHero.MiniMapSize);
  end;
end;


function InfoScreen.ItemPanel.OnUpdate()
  if Engine.IsInGame() and User then
    if InfoScreen.ItemPanel.EnabledSide and Menu.IsKeyDown(InfoScreen.Menu.ItemPanel.MoveKey) then
      InfoScreen.ItemPanel.PositionX, InfoScreen.ItemPanel.PositionY = Renderer.WorldToScreen(Input.GetWorldCursorPos());
      Menu.SetValue(InfoScreen.Menu.ItemPanel.PositionX, InfoScreen.ItemPanel.PositionX);
      Menu.SetValue(InfoScreen.Menu.ItemPanel.PositionY, InfoScreen.ItemPanel.PositionY);
    end;
    --if (InfoScreen.ItemPanel.Timer <= GameTime) 
    --then
    --  InfoScreen.ItemPanel.Timer = GameTime + InfoScreen.ItemPanel.TimerInterval;
      --local index = 0;
      --for entity, EnemyHero in pairs(Global.EnemyHeroes) do
      --  LoadHeroImages(entity, EnemyHero);
      --end;
    --end;
  end;
end;
--[[
function InfoScreen.LoadHeroImages(entity, EnemyHero)
  if (InfoScreen.ItemPanel.Timer <= GameTime) then
    InfoScreen.ItemPanel.Timer = GameTime + InfoScreen.ItemPanel.TimerInterval;
    --local index = 0;
    --for entity, EnemyHero in pairs(Global.EnemyHeroes) do
      LoadHeroImages(entity, EnemyHero);
    --end;
  end;
end;
]]

function InfoScreen.ItemPanel.DrawSideBar(entity, EnemyHero, index)
  if Engine.IsInGame() and User then
    if InfoScreen.ItemPanel.EnabledSide then
      --local index = 0;
      --for entity, EnemyHero in pairs(Global.EnemyHeroes) do
        InfoScreen.ItemPanel.DrawHeroSideBar(entity, EnemyHero, index);
        --index = index + 1;
      --end;
    end;
  end;
end;

function InfoScreen.MissingHero.Draw(entity, EnemyHero, index)
  if InfoScreen.MissingHero.Enabled and Engine.IsInGame() and User then
    InfoScreen.MissingHero.DrawHeroSideBar(entity, EnemyHero, index);
  end;
end;

function InfoScreen.OnUpdate()
  if InfoScreen.isEnabled() then
    GameTime = GameRules.GetGameTime();
    UpdateCount = UpdateCount + 1;
    if (UpdateCount>1000000000) then
      UpdateCount = 0;
    end;
    InfoScreen.Menu.ItemPanel.LoadSettings();
    InfoScreen.Menu.MissingHero.LoadSettings();
    --InfoScreen.Renderer.CalcPanelSize();
    
    User:Update(Heroes.GetLocal());
    InfoScreen.EnemyHeroes.OnUpdate();

    InfoScreen.EnemyTeamStatus.OnDraw();
    
    if (Menu.IsKeyDownOnce(InfoScreen.Menu.MissingHero.ToggleKey)) then  
      InfoScreen.MissingHero.Enabled = not InfoScreen.MissingHero.Enabled;
      Menu.SetEnabled(InfoScreen.Menu.MissingHero.Enabled, InfoScreen.MissingHero.Enabled);
    end;
    
    local index = 0;
    for entity, EnemyHero in pairs(Global.EnemyHeroes) do 
      InfoScreen.MissingHero.Draw(entity, EnemyHero, index);
      InfoScreen.ItemPanel.DrawSideBar(entity, EnemyHero, index);
      
      if (InfoScreen.ItemPanel.Timer <= GameTime) then
        InfoScreen.LoadHeroImages(entity, EnemyHero);
      end;
      if (InfoScreen.EnemyTeamStatus.Timer <= GameTime) then
        InfoScreen.EnemyTeamStatus.OnUpdate(entity, EnemyHero);
      end;
      if (InfoScreen.ImmunitySphere.Timer <= GameTime) then
        InfoScreen.ImmunitySphere.OnUpdate(entity, EnemyHero); 
      end;
      
      
      --InfoScreen.ItemPanel.DrawHeroSideBar(entity, EnemyHero, index);
      index = index + 1;
    end;
    
    if (InfoScreen.ItemPanel.Timer <= GameTime) then
      InfoScreen.ItemPanel.Timer = GameTime + InfoScreen.ItemPanel.TimerInterval;
    end;
    if (InfoScreen.EnemyTeamStatus.Timer <= GameTime) then
      InfoScreen.EnemyTeamStatus.Timer = GameTime + InfoScreen.EnemyTeamStatus.TimerInterval;
    end;
    if (InfoScreen.ImmunitySphere.Timer <= GameTime) then
      InfoScreen.ImmunitySphere.Timer = GameTime + InfoScreen.ImmunitySphere.TimerInterval;
    end;
    
    InfoScreen.ItemPanel.OnUpdate();
    InfoScreen.Pseudo.OnUpdate();
  end;
  
end;

function InfoScreen.Pseudo.OnDraw()
  if InfoScreen.Pseudo.isEnabled() and InfoScreen.Pseudo.Enabled and Engine.IsInGame() and User and User.Valid then
    User:GetAbsOrigin(); 
    User.AbsOrigin:SetZ(User.AbsOrigin:GetZ() + User.HealthBarOffset);
    local hx, hy = Renderer.WorldToScreen(User.AbsOrigin);
    local i = 0;
    for name, chanselist in pairs(InfoScreen.Pseudo.FindedList) do
      if InfoScreen.Menu.Pseudo.Panels[chanselist[1]] and Menu.IsEnabled(InfoScreen.Menu.Pseudo.Panels[chanselist[1]]) then
        Renderer.DrawHPBar(hx + InfoScreen.Renderer.XUserBarOffset, hy + InfoScreen.Renderer.YTopUserBarOffset, InfoScreen.Renderer.HPUserBarWidth, InfoScreen.Renderer.HPBarHeight, {244, 244, 0, 125}, chanselist[2], chanselist[1], i);
        i = i + 1;
      end;
    end;
  end;
end;

function InfoScreen.Renderer.DrawHeroIconBar(XIndex, YIndex, color, percent)
  Renderer.DrawHPBar(
    InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * XIndex + InfoScreen.Renderer.BorderSize * 1,-- + index, 
    InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * YIndex, 
    InfoScreen.EnemyTeamStatus.CellWidth - InfoScreen.Renderer.BorderSize * 3,
    InfoScreen.EnemyTeamStatus.CellHeight,
    color,
    percent
  );
  --[[
  Renderer.SetDrawColor(color[1], color[2], color[3], color[4]);
  Renderer.DrawFilledShadowedRect(
    InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * Xindex + InfoScreen.Renderer.BorderSize * 1 + index, 
    InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * YIndex, 
    ceil(InfoScreen.EnemyTeamStatus.CellWidth * percent) - InfoScreen.Renderer.BorderSize * 3,
    InfoScreen.EnemyTeamStatus.CellHeight - InfoScreen.Renderer.BorderSize
  );
  ]]
end;

function InfoScreen.EnemyTeamStatus.OnDraw()
  if User and Menu.IsEnabled(InfoScreen.Menu.EnemyTeamStatus) 
  and InfoScreen.EnemyTeamStatus.uix
  then
    --Renderer.SetDrawColor(0, 0, 0, 255);
    --Renderer.DrawFilledRect(InfoScreen.EnemyTeamStatus.uix , InfoScreen.EnemyTeamStatus.uiy, InfoScreen.Renderer.TopHeroIconsWidth, InfoScreen.Renderer.TopHeroIconsHeight);
    if InfoScreen.EnemyTeamStatus.TeamOffcet == 1 then
      for k, enemyData in pairs(InfoScreen.EnemyTeamStatus.EnemyData) do
        if k == 0 then
          InfoScreen.EnemyTeamStatus.TeamOffcet = 0;
          break;
        end;
      end;
    end;
    for k, enemyData in pairs(InfoScreen.EnemyTeamStatus.EnemyData) do
      local index = k - InfoScreen.EnemyTeamStatus.TeamOffcet;
      local EnemyHero = Global.EnemyHeroes[enemyData.Entity];
      if Entity.IsAlive(enemyData.Entity) or (Hero.GetRespawnTime(enemyData.Entity) < GameTime) then

        InfoScreen.Renderer.DrawHeroIconBar(index, 0, {243, 61, 0, 255}, (EnemyHero.HP / EnemyHero.MaxHP));
        InfoScreen.Renderer.DrawHeroIconBar(index, 1, {79, 120, 250, 255}, (EnemyHero.MP / EnemyHero.MaxMP));
        --InfoScreen.Renderer.DrawHeroIconBar(index, 2, {245, 216, 103, 255}, 1);
        
        if (enemyData.BuyBackTime ~= 0) then
          Renderer.SetDrawColor(0, 0, 0, 255);
          Renderer.DrawTextAlign(InfoScreen.Renderer.Font, 
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index - InfoScreen.Renderer.BorderSize, 
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 2, 
            InfoScreen.EnemyTeamStatus.CellWidth, InfoScreen.EnemyTeamStatus.CellHeight,
            dispTime(enemyData.BuyBackTime - GameTime), 0, 0);
        end;
        --[[
        if Player.GetBuybackCooldownTime(Players.Get(k)) then
          Renderer.DrawText(InfoScreen.Renderer.Font, 
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + InfoScreen.Renderer.BorderSize + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
            -2 + InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 2, 
            tostring(Player.GetBuybackCooldownTime(Players.Get(k))), 1);
        end;
        ]]
      elseif  (Hero.GetRespawnTime(enemyData.Entity) > GameTime) then
        if (enemyData.BuyBackTime == 0 or enemyData.BuyBackTime < GameTime) then
          Renderer.SetDrawColor(245, 216, 103, 255);
          Renderer.DrawFilledShadowedRect(
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index - InfoScreen.Renderer.BorderSize + index, 
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 1.35, 
            InfoScreen.EnemyTeamStatus.CellWidth + InfoScreen.Renderer.BorderSize, InfoScreen.Renderer.TopHeroIconsRespawnHeight - InfoScreen.EnemyTeamStatus.CellHeight * 2);
          if InfoScreen.Renderer.ImageBB then
            Renderer.SetDrawColor(255, 255, 255, 255);
            Renderer.DrawImage(InfoScreen.Renderer.ImageBB, 
              InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + index,
              InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3,
              ceil(InfoScreen.EnemyTeamStatus.CellWidth * 0.28), ceil(InfoScreen.EnemyTeamStatus.CellWidth * 0.28));
          end;
        elseif InfoScreen.Renderer.ImageNoBB then
          Renderer.SetDrawColor(255, 255, 255, 255);
          Renderer.DrawImage(InfoScreen.Renderer.ImageNoBB, 
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + index,
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3,
            ceil(InfoScreen.EnemyTeamStatus.CellWidth / 4), ceil(InfoScreen.EnemyTeamStatus.CellWidth / 4));
        end;
      end;
      --for ultimate check 
      if enemyData.Ultimate.Ability and enemyData.Ultimate.Icon then 
        --draw border
        if (Ability.GetLevel(enemyData.Ultimate.Ability) >= 1) and (EnemyHero.MP>Ability.GetManaCost(enemyData.Ultimate.Ability)) and (enemyData.Ultimate.Cooldown == 0) then
          Renderer.SetDrawColor(22, 222, 22, 255);
          Renderer.DrawOutlineRect(
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3, 
            ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2, ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2);
          Renderer.SetDrawColor(255, 255, 255, 255);
        else--if (enemyData.Ultimate.Cooldown > 0) or (Ability.GetLevel(enemyData.Ultimate.Ability) < 1) then
          Renderer.SetDrawColor(222, 22, 22, 255);
          Renderer.DrawOutlineRect(
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3, 
            ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2, ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2);
        --else
          if (EnemyHero.MP<Ability.GetManaCost(enemyData.Ultimate.Ability)) then
            Renderer.SetDrawColor(22, 22, 222, 255);
          end;
        end;
        if (Ability.GetLevel(enemyData.Ultimate.Ability) < 1) then
          Renderer.SetDrawColor(128, 128, 128, 255);
        end;
        --draw image
        if enemyData.Ultimate.Icon then
          Renderer.DrawImage(enemyData.Ultimate.Icon, 
            InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + InfoScreen.Renderer.BorderSize + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
            InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3 + 1, 
            ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize * 2), ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize * 2));
        end;
        --cooldown
        if (Ability.GetLevel(enemyData.Ultimate.Ability) > 0) then
          if (enemyData.Ultimate.Cooldown - GameTime > 0) and (enemyData.Ultimate.CooldownLength > 0) then
            Renderer.SetDrawColor(200, 200, 200, 128);
            Renderer.DrawFilledRect(
              InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + InfoScreen.Renderer.BorderSize + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
              InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3, 
              ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2), ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2 * (enemyData.Ultimate.Cooldown - GameTime) / enemyData.Ultimate.CooldownLength));
            Renderer.SetDrawColor(255, 255, 255, 255);
          end;
          if (enemyData.Ultimate.Cooldown - GameTime > 0) then
            Renderer.DrawTextAlign(InfoScreen.Renderer.FontBig, 
              --InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + InfoScreen.Renderer.BorderSize + ceil(InfoScreen.EnemyTeamStatus.CellWidth / 5), 
              ---1 + InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3,-- + ceil(InfoScreen.EnemyTeamStatus.CellHeight / 2.7), 
              InfoScreen.EnemyTeamStatus.uix + InfoScreen.EnemyTeamStatus.CellWidth * index + InfoScreen.Renderer.BorderSize + ceil(InfoScreen.EnemyTeamStatus.CellWidth * InfoScreen.Renderer.TopHeroIconsSkillSize), 
              InfoScreen.EnemyTeamStatus.uiy + InfoScreen.EnemyTeamStatus.CellHeight * 3 + 1, 
              ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2, ceil(InfoScreen.EnemyTeamStatus.CellWidth / 2) + 2,
              ceil(enemyData.Ultimate.Cooldown - GameTime), 0, 0);
          end;
        end;
      end;
      index = index + 1;
      if index>5 then
        InfoScreen.EnemyTeamStatus.EnemyData = {};
        break;
      end;
    end;
  end;
end;

function InfoScreen.ItemPanel.DrawHeroBar(entity, EnemyHero)
  if Engine.IsInGame() and User then
    if InfoScreen.ItemPanel.HeroPanel then
      --local index = 0;
      --for entity, EnemyHero in pairs(Global.EnemyHeroes) do
        if EnemyHero.Valid then
          InfoScreen.ItemPanel.DrawOverHeroBar(entity, EnemyHero);
        end;
      --end;
    end;
  end;
end;

function InfoScreen.ManaBar.OnDraw(entity, EnemyHero)
  if User and Menu.IsEnabled(InfoScreen.Menu.ManaBar) or Menu.IsEnabled(InfoScreen.Menu.HealthText) and Engine.IsInGame() then
    --for entity, EnemyHero in pairs(Global.EnemyHeroes) do
      if EnemyHero.Valid then
        local origin = Entity.GetAbsOrigin(entity); 
        local HBO = EnemyHero.HBO; 
        origin:SetZ(origin:GetZ() + HBO);
        local hx, hy = Renderer.WorldToScreen(origin);
        if Renderer.IsOnScreen(hx, hy) and Menu.IsEnabled(InfoScreen.Menu.ManaBar) then
          if (InfoScreen.Renderer.XBarOffset == 0) or (InfoScreen.Renderer.YBarOffset == 0) then
            InfoScreen.Renderer.CalcPanelSize();
          end;
          local MP = ceil(EnemyHero.MP);
          local MaxMP = ceil(EnemyHero.MaxMP);
          local MPText = MP.."/"..MaxMP;
          Renderer.DrawHPBar(hx + InfoScreen.Renderer.XBarOffset, hy + InfoScreen.Renderer.YBarOffset, InfoScreen.Renderer.HPBarWidth, InfoScreen.Renderer.HPBarHeight, {79, 120, 250, 255}, (MP / MaxMP), MPText, -2);
        end;
        if Renderer.IsOnScreen(hx, hy) and Menu.IsEnabled(InfoScreen.Menu.HealthText) then
          local HP = ceil(EnemyHero.HP);
          local MaxHP = ceil(EnemyHero.MaxHP);
          local HPText = HP.."/"..MaxHP;

          Renderer.SetDrawColor(222, 222, 222, 255);
          --local w, h = Renderer.GetTextSize(InfoScreen.Renderer.Font, HPText);
          Renderer.DrawTextAlign(InfoScreen.Renderer.Font, hx + InfoScreen.Renderer.XBarOffset, 
          hy + InfoScreen.Renderer.YBarOffset + InfoScreen.Renderer.HPBarHeight, InfoScreen.Renderer.HPBarWidth, InfoScreen.Renderer.HPBarHeight, HPText, 0, 0);
        end;
      end;
    --end;
  end;
end;

function InfoScreen.OnDraw()
  if InfoScreen.isEnabled() then
  --GameTime = GameRules.GetGameTime();  
    InfoScreen.Pseudo.OnDraw();
    for entity, EnemyHero in pairs(Global.EnemyHeroes) do
      InfoScreen.ManaBar.OnDraw(entity, EnemyHero);
      InfoScreen.ItemPanel.DrawHeroBar(entity, EnemyHero);
      if InfoScreen.MissingHero.OnMinimapEnbled then
        InfoScreen.MissingHero.DrawHeroMinimap(entity, EnemyHero);
      end;
    end;
  end;
end;

function InfoScreen.OnGameStart()
  User = D2Unit:new(Heroes.GetLocal());
  InfoScreen.Pseudo.OldHP = User.HP;--костыль
  InfoScreen.Renderer.CalcPanelSize();
  InfoScreen.Menu.MissingHero.LoadSettings();
  InfoScreen.Menu.ItemPanel.LoadSettings();

  if not InfoScreen.Renderer.Font then 
    InfoScreen.Renderer.Font = Renderer.LoadFont("Tahoma", ceil(Renderer.ScreenHeight / 80), Enum.FontWeight.EXTRABOLD);
  end;
  if not InfoScreen.Renderer.FontMid then 
    InfoScreen.Renderer.FontMid = Renderer.LoadFont("Tahoma", ceil(Renderer.ScreenHeight / 55), Enum.FontWeight.EXTRABOLD);
  end;
  if not InfoScreen.Renderer.FontBig then 
    InfoScreen.Renderer.FontBig = Renderer.LoadFont("Tahoma", ceil(Renderer.ScreenHeight / 45), Enum.FontWeight.EXTRABOLD);
  end;
  if not InfoScreen.MissingHero.Font then
    InfoScreen.MissingHero.Font = Renderer.LoadFont("Arial Black", ceil(InfoScreen.MissingHero.Size * 1.5), Enum.FontWeight.EXTRABOLD);
  end;
end;
function InfoScreen.OnGameEnd()
  User = nil;
  for name, option in pairs(InfoScreen.Menu.Pseudo.Panels) do
    Menu.RemoveOption(option);
  end;
  InfoScreen.Menu.Pseudo.Panels = {};
  Global = {};
	Global.EnemyHeroes = {};
	Global.Skills = {};
	Global.Items = {};
	Global.Abilities = {};
end;

function InfoScreen.OnMenuOptionChange(option, oldValue, newValue)
  if (option == InfoScreen.Menu.MissingHero.SizeImg) then
    InfoScreen.MissingHero.Font = Renderer.LoadFont("Arial Black", ceil(InfoScreen.MissingHero.Size * 1.5), Enum.FontWeight.EXTRABOLD);
  end;
end;
if Engine.IsInGame() then
  InfoScreen.OnGameStart();
end;

return InfoScreen;