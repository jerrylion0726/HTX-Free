//
//  ResourceData.swift
//  PublicResourceFinder
//
//  Real public resources in Houston, Texas.
//  Addresses, phone numbers, hours, and coordinates collected July 2026.
//  Hours change — call ahead before visiting.
//

import Foundation

let allResources: [Resource] = [

    // MARK: - Libraries

    Resource(
        id: "lib-central",
        name: "Houston Public Library – Central Library",
        category: .library,
        address: "500 McKinney St, Houston, TX 77002",
        hours: "Mon 12PM–6PM · Tue–Fri 9AM–6PM · Sat 10AM–6PM · Sun Closed",
        phone: "(832) 393-1313",
        details: "Houston's main public library. Free books, computers, Wi-Fi, printing, study space, and passport services. A library card is free for Houston residents. One hour of free parking in the garage.",
        website: "https://houstonlibrary.org",
        latitude: 29.759454,
        longitude: -95.369934
    ),

    Resource(
        id: "lib-montrose",
        name: "Montrose Library",
        category: .library,
        address: "1001 California St, Houston, TX 77006",
        hours: "Mon–Wed 10AM–6PM · Thu 12PM–8PM · Fri 1PM–5PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 393-1800",
        details: "Modern branch on the 2nd and 3rd floors of the Montrose Collective. Large reading room, free Wi-Fi and printing, a dedicated kids and teen floor, and an outdoor terrace. Free garage parking with validation.",
        website: "https://houstonlibrary.org",
        latitude: 29.745316,
        longitude: -95.390769
    ),

    Resource(
        id: "lib-kendall",
        name: "Kendall Neighborhood Library & Community Center",
        category: .library,
        address: "609 N Eldridge Pkwy, Houston, TX 77079",
        hours: "Mon & Thu 12PM–8PM · Tue–Wed 10AM–6PM · Fri 1PM–5PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 393-1880",
        details: "Three-floor branch with a separate floor for kids and teens, two bookable private study rooms, a large conference room, and free computer access.",
        website: "https://houstonlibrary.org",
        latitude: 29.772859,
        longitude: -95.620551
    ),

    Resource(
        id: "lib-young",
        name: "Alice McKean Young Neighborhood Library",
        category: .library,
        address: "5107 Griggs Rd, Houston, TX 77021",
        hours: "Mon & Thu 12PM–8PM · Tue–Wed 10AM–6PM · Fri 1PM–5PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 393-2140",
        details: "Neighborhood branch near MLK Blvd with well-lit reading spaces, free printing, and a solid fiction and non-fiction collection.",
        website: "https://houstonlibrary.org",
        latitude: 29.698381,
        longitude: -95.337108
    ),

    Resource(
        id: "lib-collier",
        name: "Everett Collier Regional Library",
        category: .library,
        address: "6200 Pinemont Dr, Houston, TX 77092",
        hours: "Mon & Thu 12PM–8PM · Tue–Wed 10AM–6PM · Fri 1PM–5PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 393-1740",
        details: "Regional library with a very large children's area, a teen section, a summer reading program, an on-site passport office, and an ongoing used book sale.",
        website: "https://houstonlibrary.org",
        latitude: 29.840543,
        longitude: -95.482521
    ),

    Resource(
        id: "lib-stellalink",
        name: "McGovern-Stella Link Neighborhood Library",
        category: .library,
        address: "7405 Stella Link Rd, Houston, TX 77025",
        hours: "Mon & Thu 12PM–8PM · Tue–Wed 10AM–6PM · Fri 1PM–5PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 393-2630",
        details: "Neighborhood branch with mobile printing from your phone via QR code, reservable private rooms for small groups, and a twice-monthly book club open to the public.",
        website: "https://houstonlibrary.org",
        latitude: 29.698034,
        longitude: -95.439701
    ),

    // MARK: - Food Assistance

    Resource(
        id: "food-hfb-main",
        name: "Houston Food Bank",
        category: .foodAssistance,
        address: "535 Portwall St, Houston, TX 77029",
        hours: "Mon–Fri 8AM–5PM · Sat 9AM–12PM · Sun Closed",
        phone: "(713) 223-3700",
        details: "The largest food bank in the United States by distribution. Provides free groceries through a network of partner pantries and neighborhood drive-through distributions. Call or check the website to find the closest distribution site to you.",
        website: "https://houstonfoodbank.org",
        latitude: 29.780453,
        longitude: -95.274150
    ),

    Resource(
        id: "food-hfb-north",
        name: "Houston Food Bank – North Location",
        category: .foodAssistance,
        address: "146 Knobcrest Dr, Houston, TX 77060",
        hours: "Mon–Sat 7AM–4:30PM · Sun Closed",
        phone: "(713) 223-3700",
        details: "North Houston branch of the Houston Food Bank. Free grocery distribution and a donation drop-off point.",
        website: "https://houstonfoodbank.org",
        latitude: 29.955127,
        longitude: -95.415565
    ),

    Resource(
        id: "food-target-hunger",
        name: "Target Hunger",
        category: .foodAssistance,
        address: "1260 Shotwell St, Houston, TX 77020",
        hours: "Mon–Fri 9AM–5PM · Sat–Sun Closed",
        phone: "(832) 767-1677",
        details: "Neighborhood food pantry serving northeast Houston. Staff also help residents apply for SNAP, medical assistance, and rental assistance, and will walk you through the paperwork.",
        website: "https://targethunger.org",
        latitude: 29.764537,
        longitude: -95.311804
    ),

    Resource(
        id: "food-second-servings",
        name: "Second Servings of Houston",
        category: .foodAssistance,
        address: "8825 Knight Rd, Houston, TX 77054",
        hours: "Mon–Thu 8:45AM–4PM · Fri 8:45AM–2PM · Sat 8:30AM–12:30PM · Sun 9:30AM–12:30PM",
        phone: "(713) 824-4763",
        details: "Nonprofit food rescue that collects surplus food from restaurants and grocers and redistributes it to shelters. Also runs a free pantry open to the public, including weekends.",
        website: "https://secondservings.org",
        latitude: 29.676782,
        longitude: -95.399664
    ),

    Resource(
        id: "food-bridging",
        name: "Bridging For Tomorrow",
        category: .foodAssistance,
        address: "5359 W Richey Rd, Houston, TX 77066",
        hours: "Mon–Thu 9AM–4PM · Fri 9AM–2PM · Sat–Sun Closed",
        phone: "(281) 203-0830",
        details: "North Houston community organization providing free food distribution alongside youth summer and after-school programs. Call ahead to confirm pickup times before you go.",
        website: "",
        latitude: 29.959558,
        longitude: -95.499361
    ),

    Resource(
        id: "food-east-end",
        name: "East End Social Services",
        category: .foodAssistance,
        address: "4103 Mowery Rd, Houston, TX 77047",
        hours: "Mon–Wed 8AM–11AM & 1PM–4PM · Thu–Sun Closed",
        phone: "(713) 928-3823",
        details: "Food pantry with a once-per-month check-in. Distributions often include frozen, ready-to-heat entrees in addition to canned and dry goods. Hours are limited, so arrive early.",
        website: "",
        latitude: 29.636450,
        longitude: -95.363036
    ),

    // MARK: - Community Centers

    Resource(
        id: "cc-alief",
        name: "Alief Neighborhood Center",
        category: .communityCenter,
        address: "11903 Bellaire Blvd, Houston, TX 77072",
        hours: "Mon–Fri 12PM–8PM · Sat 10AM–5PM · Sun Closed",
        phone: "(832) 395-7075",
        details: "Large multi-service campus with a free swimming pool, gym, indoor basketball court, tennis courts, playground, and harvest garden. Also houses a library with 3D printing, plus WIC and passport services.",
        website: "https://www.houstontx.gov/parks",
        latitude: 29.702778,
        longitude: -95.588889
    ),

    Resource(
        id: "cc-trini",
        name: "Trini Mendenhall Community Center",
        category: .communityCenter,
        address: "1414 Wirt Rd, Houston, TX 77055",
        hours: "Mon–Fri 8AM–8PM · Sat 8AM–4PM · Sun Closed",
        phone: "(713) 956-0881",
        details: "City community center known for senior programs, fitness and yoga classes, and affordable rentable event space. Clean facilities and helpful front desk staff.",
        website: "https://www.houstontx.gov/parks",
        latitude: 29.795765,
        longitude: -95.484410
    ),

    Resource(
        id: "cc-judson",
        name: "Judson Robinson Jr. Community Center",
        category: .communityCenter,
        address: "2020 Hermann Dr, Houston, TX 77004",
        hours: "Open daily 8AM–8PM",
        phone: "(832) 395-7626",
        details: "Community center in the Museum District with a free gym and on-site trainer, youth chess tournaments, and free Saturday STEM programs. Open seven days a week.",
        website: "https://www.houstontx.gov/parks",
        latitude: 29.716667,
        longitude: -95.382071
    ),

    Resource(
        id: "cc-bayland",
        name: "Bayland Community Center",
        category: .communityCenter,
        address: "6400 Bissonnet St, Houston, TX 77074",
        hours: "Mon–Fri 7:30AM–9PM · Sat 8AM–4PM · Sun Closed",
        phone: "(713) 274-3240",
        details: "Harris County community center with many meeting rooms, family and youth programs, and public bulletin boards listing local events. Also serves as a polling location during elections.",
        website: "",
        latitude: 29.694929,
        longitude: -95.496551
    ),

    Resource(
        id: "cc-castillo",
        name: "Leonel Castillo Community Center",
        category: .communityCenter,
        address: "2101 South St, Houston, TX 77009",
        hours: "Mon, Wed, Fri 8AM–5PM · Tue & Thu 8AM–9PM · Sat–Sun Closed",
        phone: "(713) 274-2222",
        details: "Community center at the head of a city bike trail, with meeting and event space, a kitchen prep area for caterers, and a view of downtown. Parking is limited.",
        website: "https://www.houstontx.gov/parks",
        latitude: 29.778260,
        longitude: -95.367047
    ),

    Resource(
        id: "cc-shape",
        name: "SHAPE Community Center",
        category: .communityCenter,
        address: "3815 Live Oak St, Houston, TX 77004",
        hours: "Mon–Fri 7AM–6PM · Sat 9AM–5PM · Sun Closed",
        phone: "(713) 521-0641",
        details: "Long-running Third Ward community center offering youth programs, cultural and history events, an elders program, and a community kitchen. A neighborhood institution for decades.",
        website: "https://www.shapecenter.org",
        latitude: 29.729120,
        longitude: -95.366517
    ),

    Resource(
        id: "cc-sunnyside",
        name: "Sunnyside Community Center",
        category: .communityCenter,
        address: "3502 W Bellfort Ave, Houston, TX 77051",
        hours: "Mon–Fri 8AM–7PM · Sat–Sun Closed",
        phone: "(832) 395-7586",
        details: "Community center and park with twice-weekly senior fitness sessions, meeting rooms, and a walking track. Best visited during daylight hours.",
        website: "https://www.houstontx.gov/parks",
        latitude: 29.668876,
        longitude: -95.372118
    ),

    // MARK: - Health Clinics

    Resource(
        id: "health-hhh-caroline",
        name: "Healthcare for the Homeless – Caroline Street Clinic",
        category: .healthClinic,
        address: "1934 Caroline St, Houston, TX 77002",
        hours: "Mon–Thu 8AM–4:30PM · Fri 8AM–12PM · Sat–Sun Closed",
        phone: "(713) 286-6000",
        details: "Free medical, dental, behavioral health, and vision care for people experiencing homelessness. No insurance required. Staff also help with paperwork such as replacing a Social Security card. Walk-ins are accepted.",
        website: "https://www.homelesshouston.org",
        latitude: 29.748128,
        longitude: -95.368348
    ),

    Resource(
        id: "health-sanjose",
        name: "San José Clinic (Midtown)",
        category: .healthClinic,
        address: "2615 Fannin St, Houston, TX 77002",
        hours: "Mon–Fri 8AM–5PM · Sat 9AM–1PM · Sun Closed",
        phone: "(713) 228-9411",
        details: "Charity clinic staffed largely by volunteer physicians, serving uninsured patients. Offers medical, dental, vision, and pharmacy services. Note: this is low-cost rather than free, and income eligibility applies.",
        website: "https://www.sanjoseclinic.org",
        latitude: 29.744586,
        longitude: -95.373103
    ),

    Resource(
        id: "health-hope-beltway",
        name: "HOPE Clinic – Beltway Community Health Center",
        category: .healthClinic,
        address: "7001 Corporate Dr Ste 120, Houston, TX 77036",
        hours: "Mon–Thu 8AM–7PM · Fri 8AM–5PM · Sat 9AM–5PM · Sun Closed",
        phone: "(713) 773-0803",
        details: "Federally qualified health center offering primary care, pediatrics, OB-GYN, and dental services on a sliding-fee scale based on household income. Insurance is not required. Open Saturdays.",
        website: "https://www.hopechc.org",
        latitude: 29.703576,
        longitude: -95.551129
    ),

    Resource(
        id: "health-hope-alief",
        name: "HOPE Clinic – Alief Community Health Center",
        category: .healthClinic,
        address: "13930 Bellaire Blvd, Houston, TX 77083",
        hours: "Mon, Tue, Thu, Fri 8AM–5PM · Wed 11AM–7PM · Sat–Sun Closed",
        phone: "(713) 773-0803",
        details: "Community health center with primary care, women's health, OB-GYN, and dental services on a sliding-fee scale. Multilingual staff serving a diverse west Houston community.",
        website: "https://www.hopechc.org",
        latitude: 29.704432,
        longitude: -95.628134
    ),

    Resource(
        id: "health-hope-aldine",
        name: "HOPE Clinic – Aldine Community Health Center",
        category: .healthClinic,
        address: "3000 Aldine Mail Rte Rd Bldg C, Ste 200, Houston, TX 77039",
        hours: "Mon, Tue, Thu, Fri 8AM–5PM · Wed 11AM–7PM · Sat–Sun Closed",
        phone: "(713) 773-0803",
        details: "North Houston community health center offering adult medicine, pediatrics, and OB-GYN care on a sliding-fee scale. Appointments fill quickly, so book ahead when possible.",
        website: "https://www.hopechc.org",
        latitude: 29.901508,
        longitude: -95.343721
    ),

    // MARK: - Education & Tutoring

    Resource(
        id: "edu-baker-gulfton",
        name: "BakerRipley Gulfton Sharpstown Campus",
        category: .education,
        address: "6500 Rookin St, Houston, TX 77074",
        hours: "Mon–Fri 10AM–8PM · Sat–Sun Closed",
        phone: "(713) 273-3700",
        details: "Community campus offering after-school and summer programs for children, adult education and ESL classes, utility assistance, and free tax preparation. Program availability and cost vary by season, so call to confirm.",
        website: "https://www.bakerripley.org",
        latitude: 29.710716,
        longitude: -95.497609
    ),

    Resource(
        id: "edu-baker-ripley-house",
        name: "BakerRipley Ripley House Campus",
        category: .education,
        address: "4410 Navigation Blvd, Houston, TX 77011",
        hours: "Mon–Fri 10AM–7PM · Sat–Sun Closed",
        phone: "(713) 315-6400",
        details: "East End campus offering free tax preparation, adult education, workforce services, a charter school, and an on-site children's health clinic. Bring ID and Social Security card for tax help.",
        website: "https://www.bakerripley.org",
        latitude: 29.751841,
        longitude: -95.329094
    ),

    Resource(
        id: "edu-nehemiah",
        name: "Nehemiah Neighborhood Center",
        category: .education,
        address: "5015 Fannin St, Houston, TX 77004",
        hours: "Mon–Fri 8AM–6PM · Sat–Sun Closed",
        phone: "(713) 526-5015",
        details: "Nonprofit education center serving at-risk youth with a Pre-K program, after-school tutoring, and middle school programs. Scholarships are available for families who qualify.",
        website: "",
        latitude: 29.728707,
        longitude: -95.385837
    ),

    Resource(
        id: "edu-mission-milby",
        name: "Mission Milby Community Development Corporation",
        category: .education,
        address: "2220 Broadway St, Houston, TX 77012",
        hours: "Mon–Fri 9AM–6PM · Sat–Sun Closed",
        phone: "(713) 454-6464",
        details: "Neighborhood nonprofit offering GED classes, a free computer lab, summer youth programs, free AARP tax help, and immigration assistance. Food assistance is limited to two nearby ZIP codes.",
        website: "",
        latitude: 29.706908,
        longitude: -95.279046
    ),

    Resource(
        id: "edu-hcde",
        name: "Harris County Department of Education",
        category: .education,
        address: "6300 Irvington Blvd, Houston, TX 77022",
        hours: "Mon–Fri 8AM–4:30PM · Sat–Sun Closed",
        phone: "(713) 694-6300",
        details: "County education agency offering free and low-cost adult education, GED preparation, and workforce certification programs such as CNA and phlebotomy training. Confirm class schedules by phone before visiting.",
        website: "https://www.hcde-texas.org",
        latitude: 29.815855,
        longitude: -95.360672
    )
]
